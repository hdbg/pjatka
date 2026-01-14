import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker/talker.dart';

import '../exceptions/parse_exceptions.dart';

part 'asp_emulator.freezed.dart';

/// Type alias for ASP.NET state
typedef AspState = Map<String, String>;

/// Type of ASP.NET request
@freezed
sealed class RequestKind with _$RequestKind {
  const factory RequestKind.initial() = InitialRequest;
  const factory RequestKind.event({required String target, String? argument}) =
      EventRequest;
}

/// ASP.NET request configuration
@freezed
abstract class AspRequest with _$AspRequest {
  const factory AspRequest({
    @Default('') String endpoint,
    required RequestKind kind,
    @Default(false) bool isDelta,
    @Default({}) Map<String, String> stateOverride,
  }) = _AspRequest;
}

/// ASP.NET response
@freezed
abstract class AspResponse with _$AspResponse {
  const factory AspResponse({required int statusCode, String? body}) =
      _AspResponse;
}

/// ASP.NET emulator that maintains ViewState between requests
class AspEmulator {
  AspEmulator(this.urlBase, {required this.talker}) {
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  final String urlBase;
  final Talker talker;
  final AspState _state = {};
  final Dio dio = Dio();

  static const _eventTargetState = '__EVENTTARGET';
  static const _eventArgState = '__EVENTARGUMENT';

  /// Generate headers for event-based requests
  Map<String, String> _eventHeaders(bool isDelta) {
    final headers = {
      'x-requested-with': 'XMLHttpRequest',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
    };

    if (isDelta) {
      headers['x-microsoftajax'] = 'Delta=true';
    }

    return headers;
  }

  /// Update state from HTML document (initial page load)
  void _updateStateFromHtml(String text) {
    final document = html_parser.parse(text);
    final inputs = document.querySelectorAll('input');

    for (final input in inputs) {
      final id = input.attributes['id'];
      final value = input.attributes['value'];

      if (id != null && id.startsWith('__') && value != null) {
        _state[id] = value;
      }
    }
  }

  /// Update state from fragment (delta response)
  void _updateStateFromFragment(String fragmentLine) {
    final parts = fragmentLine.split('|');
    final iterator = parts.iterator;

    while (iterator.moveNext()) {
      final stateId = iterator.current;

      if (!stateId.startsWith('__')) {
        continue;
      }

      if (iterator.moveNext()) {
        final stateValue = iterator.current;
        _state[stateId] = stateValue;
      }
    }
  }

  /// Process response and update state
  Future<AspResponse> _processResponse(
    Response<String> response,
    String? Function(String body) updateState,
  ) async {
    final statusCode = response.statusCode ?? 500;
    final text = response.data ?? '';

    String? body = text.isNotEmpty ? text : null;

    if (body != null) {
      try {
        body = updateState(body);
      } catch (e, st) {
        throw ParseException.parsingFailed(
          message: 'Failed to update state: $e',
          stackTrace: st,
        );
      }
    }

    return AspResponse(statusCode: statusCode, body: body);
  }

  /// Execute an ASP.NET request
  Future<AspResponse> request(AspRequest req) async {
    final url = urlBase + req.endpoint;

    try {
      switch (req.kind) {
        case InitialRequest():
          {
            final response = await dio.get<String>(url);
            return await _processResponse(response, (body) {
              _updateStateFromHtml(body);
              return body;
            });
          }
        case EventRequest(:final target, :final argument):
          {
            return await _eventRequest(target, argument, req, url);
          }
      }
    } on DioException catch (e, st) {
      talker.handle(e, st);
      throw ParseException.http(
        message: 'HTTP request failed: ${e.message}',
        stackTrace: st,
      );
    }
  }

  Future<AspResponse> _eventRequest(String target, String? argument, AspRequest req, String url) async {
    final state = Map<String, String>.from(_state);
    state[_eventTargetState] = target;
    state[_eventArgState] = argument ?? '';
    
    // Apply state overrides
    state.addAll(req.stateOverride);
    
    // Set headers
    final headers = _eventHeaders(req.isDelta);
    
    // Send POST request
    final response = await dio.post<String>(
      url,
      data: state,
      options: Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    
    return await _processResponse(response, (body) {
      final lines = body.split('\n');
      if (lines.length <= 1) {
        throw const ParseException.bodyAbruptied(
          message: 'Response has no fragment line',
        );
      }
    
      // Last line contains state updates
      final fragment = lines.last;
      _updateStateFromFragment(fragment);
    
      // Update body to exclude the last line (fragment)
      lines.removeLast();
      
      if (lines.isNotEmpty) {
        lines.removeAt(0);
      }
    
      return lines.join('\n');
    });
  }

  /// Get current ViewState (for debugging)
  Map<String, String> get currentState => Map.unmodifiable(_state);
}
