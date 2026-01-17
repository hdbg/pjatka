/// Represents a single calendar event
class Event {
  final DateTime start;
  final DateTime end;
  final String summary;
  final String? categories;

  Event({
    required this.start,
    required this.end,
    required this.summary,
    this.categories,
  });

  Duration get duration => end.difference(start);

  @override
  String toString() {
    return 'Event(summary: $summary, start: $start, end: $end)';
  }
}

/// Represents a parsed calendar with its events
class Calendar {
  final String? prodId;
  final String? version;
  final String? method;
  final List<Event> events;

  Calendar({
    this.prodId,
    this.version,
    this.method,
    required this.events,
  });

  @override
  String toString() {
    return 'Calendar(prodId: $prodId, version: $version, events: ${events.length} events)';
  }
}

/// Parser for ICS (iCalendar) format
class IcsParser {
  /// Parses an ICS string and returns a Calendar object
  static Calendar parse(String icsContent) {
    final lines = _unfoldLines(icsContent);
    
    final events = <Event>[];
    
    int i = 0;
    while (i < lines.length) {
      final line = lines[i];
      
      if (line == 'BEGIN:VEVENT') {
        final eventResult = _parseEvent(lines, i + 1);
        events.add(eventResult.event);
        i = eventResult.nextIndex;
        continue;
      }
      
      i++;
    }
    
    return Calendar(
      events: events,
    );
  }

  /// Handles line unfolding (lines starting with space/tab are continuations)
  static List<String> _unfoldLines(String content) {
    final rawLines = content.split(RegExp(r'\r?\n'));
    final result = <String>[];
    
    for (final line in rawLines) {
      if (line.startsWith(' ') || line.startsWith('\t')) {
        // Continuation of previous line
        if (result.isNotEmpty) {
          result[result.length - 1] += line.substring(1);
        }
      } else {
        result.add(line.trim());
      }
    }
    
    return result.where((line) => line.isNotEmpty).toList();
  }

  /// Extracts value after the colon
  static String _getValue(String line) {
    final colonIndex = line.indexOf(':');
    if (colonIndex == -1) return line;
    return line.substring(colonIndex + 1).trim();
  }

  /// Parses a VEVENT block
  static ({Event event, int nextIndex}) _parseEvent(List<String> lines, int startIndex) {
    DateTime? start;
    DateTime? end;
    String? summary;
    
    int i = startIndex;
    while (i < lines.length) {
      final line = lines[i];
      
      if (line == 'END:VEVENT') {
        break;
      }
      
      if (line.startsWith('DTSTART')) {
        start = _parseDateTime(line);
      } else if (line.startsWith('DTEND')) {
        end = _parseDateTime(line);
      } else if (line.startsWith('SUMMARY:')) {
        summary = _getValue(line);
      }
      
      i++;
    }
    
    if (start == null || end == null || summary == null) {
      throw FormatException('Invalid VEVENT: missing required fields');
    }
    
    return (
      event: Event(
        start: start,
        end: end,
        summary: summary,
      ),
      nextIndex: i + 1,
    );
  }

  /// Parses ICS datetime format (YYYYMMDDTHHMMSSZ or with timezone params)
  static DateTime _parseDateTime(String line) {
    final value = _getValue(line);
    
    // Format: YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ
    final match = RegExp(r'(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2})Z?').firstMatch(value);
    
    if (match == null) {
      throw FormatException('Invalid datetime format: $value');
    }
    
    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final hour = int.parse(match.group(4)!);
    final minute = int.parse(match.group(5)!);
    final second = int.parse(match.group(6)!);
    
    // If ends with Z, it's UTC
    if (value.endsWith('Z')) {
      return DateTime.utc(year, month, day, hour, minute, second);
    }
    
    return DateTime(year, month, day, hour, minute, second);
  }
}