import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';
import 'package:intl/intl.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:semaphore/semaphore.dart';

import '../../../config/api_config.dart';
import '../../../utils.dart';
import '../exceptions/parse_exceptions.dart';
import 'asp_emulator.dart';
import 'class_deductor.dart';

/// PJATK schedule parser
class PjatkParser {
  PjatkParser() {
    final endpoint = ApiConfig.scheduleEndpoint;
    talker.debug('Initializing parser with endpoint: $endpoint');
    _emulator = AspEmulator(endpoint);
  }

  late final AspEmulator _emulator;

  // CSS Selectors
  static const _reservationIdSelector = '#ctl06_TytulRezerwacjiLabel';
  static const _nameSelector = '#ctl06_NazwaPrzedmiotyLabel';
  static const _codeSelector = '#ctl06_KodPrzedmiotuLabel';
  static const _lectureKindSelector = '#ctl06_TypZajecLabel';
  static const _groupsSelector = '#ctl06_GrupyLabel';
  static const _lecturerSelector = '#ctl06_DydaktycyLabel';
  static const _roomSelector = '#ctl06_SalaLabel';
  static const _dateSelector = '#ctl06_DataZajecLabel';
  static const _fromTimeSelector = '#ctl06_GodzRozpLabel';
  static const _toTimeSelector = '#ctl06_GodzZakonLabel';

  static const _onlineColorSubstr = 'background-color:#3AEB34;';

  static const _classTableSelector = '#ZajeciaTable > tbody';
  static const _classItemSelector = 'td[id\$=";z"]'; // ends with ;z

  /// Check if the HTML is a reservation (not a class)
  bool _isReservation(DocumentFragment document) {
    final reservationElements = document.querySelectorAll(
      _reservationIdSelector,
    );
    return reservationElements.isNotEmpty;
  }

  /// Extract text from an element matching the selector
  String? _extractText(DocumentFragment document, String selector) {
    final element = document.querySelector(selector);
    return element?.text.trim();
  }

  /// Parse class details from HTML fragment
  PjatkClass? _parseDetailHtml(
    String classId,
    String fragment,
    String styleCode,
  ) {
    final document = html_parser.parseFragment(fragment);

    if (_isReservation(document)) {
      talker.debug('Skipping reservation for ID: $classId');
      return null;
    }

    final name = _extractText(document, _nameSelector);
    if (name == null || name.isEmpty) {
      talker.error('Failed to parse class name for ID: $classId');
      throw const ParseException.parsingFailed(
        message: 'Could not parse class name',
      );
    }

    final code = _extractText(document, _codeSelector);
    if (code == null || code.isEmpty) {
      talker.error('Failed to parse class code for ID: $classId');
      throw const ParseException.parsingFailed(
        message: 'Could not parse class code',
      );
    }

    final kind = _extractText(document, _lectureKindSelector);
    if (kind == null || kind.isEmpty) {
      throw const ParseException.parsingFailed(
        message: 'Could not parse lecture kind',
      );
    }

    final groups = _extractText(document, _groupsSelector);
    if (groups == null || groups.isEmpty) {
      throw const ParseException.parsingFailed(
        message: 'Could not parse groups',
      );
    }

    final lecturer = _extractText(document, _lecturerSelector);
    if (lecturer == null || lecturer.isEmpty) {
      throw const ParseException.parsingFailed(
        message: 'Could not parse lecturer',
      );
    }

    final room = _extractText(document, _roomSelector);
    if (room == null || room.isEmpty) {
      throw const ParseException.parsingFailed(message: 'Could not parse room');
    }

    final date = _extractText(document, _dateSelector);
    if (date == null || date.isEmpty) {
      throw const ParseException.parsingFailed(message: 'Could not parse date');
    }

    final from = _extractText(document, _fromTimeSelector);
    if (from == null || from.isEmpty) {
      throw const ParseException.parsingFailed(
        message: 'Could not parse from time',
      );
    }

    final to = _extractText(document, _toTimeSelector);
    if (to == null || to.isEmpty) {
      throw const ParseException.parsingFailed(
        message: 'Could not parse to time',
      );
    }

    final isOnline = styleCode.contains(_onlineColorSubstr);

    return PjatkClass(
      id: classId,
      name: name,
      code: code,
      kind: kind,
      groups: groups,
      lecturer: lecturer,
      room: room,
      from: from,
      to: to,
      date: date,
      isOnline: isOnline,
    );
  }

  /// Collect class IDs from schedule table
  List<(String, String)> _collectClassIds(String documentText) {
    talker.debug('Collecting class IDs from schedule table');
    final body = html_parser.parse(documentText);

    // Find the class table
    final table = body.querySelector(_classTableSelector);
    if (table == null) {
      talker.warning('No class table found in document');
      return [];
    }

    // Find all class items (ending with ;z)
    final classItems = table.querySelectorAll(_classItemSelector);
    final classIdStyleCollected = <(String, String)>[];

    for (final classItem in classItems) {
      final id = classItem.attributes['id'];
      if (id == null) continue;

      final style = classItem.attributes['style'] ?? '';
      classIdStyleCollected.add((id, style));
    }

    talker.debug('Found ${classIdStyleCollected.length} class items');
    return classIdStyleCollected;
  }

  /// Prepare state for date picker update
  Map<String, String> _prepareDateUpdateState(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);

    return {
      'RadScriptManager1': 'RadAjaxPanel1Panel|DataPicker',
      '__EVENTTARGET': 'DataPicker',
      '__EVENTARGUMENT': '',
      'DataPicker': dateStr,
      'DataPicker\$dateInput': dateStr,
      'DataPicker_dateInput_ClientState': jsonEncode({
        'enabled': true,
        'emptyMessage': '',
        'validationText': '$dateStr-00-00-00',
        'valueAsString': '$dateStr-00-00-00',
        'minDateStr': '1980-01-01-00-00-00',
        'maxDateStr': '2099-12-31-00-00-00',
        'lastSetTextBoxValue': dateStr,
      }),
      'DataPicker_ClientState': '',
      '__ASYNCPOST': 'true',
      'RadAJAXControlID': 'RadAjaxPanel1',
      'RadScriptManager1_TSM':
          ';;System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35:en-US:ceece802-cb39-4409-a6c9-bfa3b2c8bf10:ea597d4b:b25378d2;Telerik.Web.UI, Version=2018.1.117.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4:en-US:3346c3e6-3c4c-4be3-94e3-1928d6a828a1:16e4e7cd:f7645509:ed16cbdc:88144a7a:33715776:24ee1bba:f46195d3:c128760b:874f8ea2:19620875:cda80b3:383e4ce8:1e771326:2003d0b8:aa288e2d:258f1c72:8674cba1:7c926187:b7778d6c:c08e9f8a:a51ee93e:59462f1:6d43f6d9:2bef5fcc:e06b58fd',
    };
  }

  /// Parse class detail by triggering tooltip
  Future<PjatkClass?> _parseDetail(String classId, String style) async {
    final state = <String, String>{
      'RadScriptManager1':
          'RadToolTipManager1RTMPanel|RadToolTipManager1RTMPanel',
      'RadToolTipManager1_ClientState': jsonEncode({
        'AjaxTargetControl': classId,
        'Value': classId,
      }),
      'RadToolTipManager2_ClientState': '',
      '__ASYNCPOST': 'true',
      'DataPicker_ClientState': '',
      'RadScriptManager1_TSM':
          ';;System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35:en-US:ceece802-cb39-4409-a6c9-bfa3b2c8bf10:ea597d4b:b25378d2;Telerik.Web.UI, Version=2018.1.117.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4:en-US:3346c3e6-3c4c-4be3-94e3-1928d6a828a1:16e4e7cd:f7645509:ed16cbdc:88144a7a:33715776:24ee1bba:f46195d3:c128760b:874f8ea2:19620875:cda80b3:383e4ce8:1e771326:2003d0b8:aa288e2d:258f1c72:8674cba1:7c926187:b7778d6c:c08e9f8a:a51ee93e:59462f1:6d43f6d9:2bef5fcc:e06b58fd',
    };

    final req = AspRequest(
      kind: const EventRequest(
        target: 'RadToolTipManager1RTMPanel',
        argument: 'undefined',
      ),
      isDelta: true,
      stateOverride: state,
    );

    final response = await _emulator.request(req);

    final fragmentHtml = response.body;
    if (fragmentHtml == null) {
      talker.error('No body in tooltip response for class ID: $classId');
      throw const ParseException.bodyAbruptied(
        message: 'No body in tooltip response',
      );
    }

    return _parseDetailHtml(classId, fragmentHtml, style);
  }

  /// Parse all classes for a given day (raw data)
  Future<List<PjatkClass>> _parseDayRaw(DateTime requestedDate) async {
    final dateStr = DateFormat('yyyy-MM-dd').format(requestedDate);
    talker.info('Starting to parse schedule for date: $dateStr');

    // Initial request
    talker.debug('Sending initial request to PJATK schedule');
    final initialReq = AspRequest(kind: const InitialRequest());
    var response = await _emulator.request(initialReq);
    talker.debug('Initial request completed');

    // If not today, update to specific date
    final now = DateTime.now();
    final isToday =
        requestedDate.year == now.year &&
        requestedDate.month == now.month &&
        requestedDate.day == now.day;

    if (!isToday) {
      talker.debug('Updating calendar to date: $dateStr');
      final state = _prepareDateUpdateState(requestedDate);
      final dateReq = AspRequest(
        kind: const EventRequest(target: 'DataPicker'),
        isDelta: true,
        stateOverride: state,
      );
      response = await _emulator.request(dateReq);
      talker.debug('Date update completed');
    } else {
      talker.debug('Using today\'s schedule (no date update needed)');
    }

    // Collect class IDs
    final responseText = response.body;
    if (responseText == null) {
      talker.error('No body in schedule response');
      throw const ParseException.bodyAbruptied(
        message: 'No body in schedule response',
      );
    }

    final classIdStylePairs = _collectClassIds(responseText);

    if (classIdStylePairs.isEmpty) {
      talker.info('No classes found for date: $dateStr');
      return [];
    }

    // Parse each class detail
    talker.info('Fetching details for ${classIdStylePairs.length} classes...');

     final sm = LocalSemaphore(8);

    final jobList = classIdStylePairs.map((packed) async {
      await sm.acquire();
      final (classId, style) = packed;
      try {
        final classData = await _parseDetail(classId, style);
        if (classData != null) {
          return classData;
        } else {
          throw const ParseException.parsingFailed(
            message: 'Class is a reservation or invalid',
          );
        }
      } catch (e, stackTrace) {
        talker.error('Failed to parse class $classId', e, stackTrace);
        rethrow;
      }
      finally {
        sm.release();
      }
    });

    final classes = await Future.wait(jobList);

    talker.info('Successfully parsed ${classes.length} classes for $dateStr');
    return classes;
  }

  Future<List<ScheduledClass>> parseDay(DateTime date) async {
    try {
      final raw = await _parseDayRaw(date);
      talker.debug(
        'Deducting and converting ${raw.length} raw classes to structured format',
      );
      final deducted = deductMulti(raw);
      talker.info(
        '✓ Parsing complete: ${deducted.length} unique classes after deduction',
      );
      return deducted;
    } catch (e, stackTrace) {
      talker.error('Failed to parse schedule', e, stackTrace);
      rethrow;
    }
  }
}
