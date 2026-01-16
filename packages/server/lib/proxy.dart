import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:pjatk_core/api_config.dart';
import 'package:relic/relic.dart';

final _dio = dio.Dio(
  dio.BaseOptions(
    followRedirects: false,
    validateStatus: (_) => true,
    responseType: dio.ResponseType.bytes,
  ),
);

Future<Response> proxyHandler(final Request req) async {
  final requestPath = req.url.path;
  print('Proxying request for path: $requestPath');

  final targetUri = Uri.parse(ApiConfig.pjatkScheduleBase).replace(
    path: '/$requestPath',
    query: req.url.query.isEmpty ? null : req.url.query,
  );

  try {
    final forwardHeaders = <String, String>{};
    for (final header in [
      'content-type',
      'accept',
      'x-requested-with',
      'x-microsoftajax',
      'cookie',
    ]) {
      final value = req.headers[header];
      if (value != null && value.isNotEmpty) {
        forwardHeaders[header] = value.first;
      }
    }

    final String? bodyContent;
    if (req.method == Method.post) {
      bodyContent = await req.readAsString();
    } else {
      bodyContent = null;
    }

    final proxyResp = await _dio.requestUri<List<int>>(
      targetUri,
      options: dio.Options(
        method: req.method.value,
        headers: forwardHeaders,
        followRedirects: false,
        responseType: dio.ResponseType.bytes,
      ),
      data: bodyContent,
    );

    final responseHeaders = <String, List<String>>{};
    proxyResp.headers.forEach((name, values) {
      final lowerName = name.toLowerCase();
      if (lowerName == 'transfer-encoding' ||
          lowerName == 'connection' ||
          lowerName == 'content-length' ||
          lowerName == 'content-encoding') {
        return;
      }

      if (lowerName == 'location') {
        final location = values.first;
        final locationUri = Uri.tryParse(location);
        if (locationUri != null) {
          final resolvedUri = locationUri.hasScheme
              ? locationUri
              : targetUri.resolve(location);

          final upstreamBase = Uri.parse(ApiConfig.pjatkScheduleBase);
          if (resolvedUri.host == upstreamBase.host) {
            final proxyLocation = req.url
                .replace(path: resolvedUri.path)
                .toString();
            responseHeaders[name] = [proxyLocation];
          } else {
            responseHeaders[name] = [resolvedUri.toString()];
          }
        }
      } else if (lowerName == 'set-cookie') {
        final rewrittenCookies = values.map((cookie) {
          // otherwise cross-origin cookies will be blocked by browsers
          return cookie.replaceAll('SameSite=Lax', 'SameSite=None; Secure');
        }).toList();
        responseHeaders[name] = rewrittenCookies;
      } else {
        responseHeaders[name] = values;
      }
    });

    final contentType =
        proxyResp.headers.value('content-type') ?? 'application/octet-stream';
    final mimeType = MimeType.parse(contentType.split(';').first.trim());

    print(proxyResp.data?.length);

    return Response(
      proxyResp.statusCode ?? HttpStatus.badGateway,
      headers: Headers.fromMap(responseHeaders),
      body: Body.fromData(
        Uint8List.fromList(proxyResp.data ?? []),
        mimeType: mimeType,
      ),
    );
  } on dio.DioException catch (e) {
    return Response.internalServerError(
      body: Body.fromString('Failed to connect to upstream: ${e.message}\n'),
    );
  }
}
