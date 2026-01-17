import 'package:intl/intl.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/parsing/exceptions/parse_exceptions.dart';
import 'package:timezone/timezone.dart' as tz;

class PjatkClass {
  PjatkClass({
    required this.id,
    required this.name,
    required this.code,
    required this.kind,
    required this.groups,
    required this.lecturer,
    required this.room,
    required this.from,
    required this.to,
    required this.date,
    required this.isOnline,
  });

  final String id;
  final String name;
  final String code;
  final String kind;
  final String groups;
  final String lecturer;
  final String room;
  final String from;
  final String to;
  final String date;
  final bool isOnline;
}

enum PjatkRawKind {
  lecture(['Wykład', 'Lektorat']),
  seminar(['Ćwiczenia', 'Internet - ćwiczenia']),
  exam(['Egzamin']),
  diplomaThesis(['Projekt dyplomowy']);

  final List<String> displayNames;

  const PjatkRawKind(this.displayNames);

  static PjatkRawKind? fromDisplayName(String name) {
    for (final kind in PjatkRawKind.values) {
      if (kind.displayNames.contains(name)) {
        return kind;
      }
    }
    return null;
  }

  ClassKind toClassKind() {
    return switch (this) {
      PjatkRawKind.lecture => ClassKind.lecture,
      PjatkRawKind.seminar => ClassKind.seminar,
      PjatkRawKind.diplomaThesis => ClassKind.diplomaThesis,
      // TODO: Handle this case.
      PjatkRawKind.exam => throw UnimplementedError(),
    };
  }
}

/// Deduct class kind from Polish class type name
ClassKind deductKind(String kind) {
  final rawKind = PjatkRawKind.fromDisplayName(kind);
  if (rawKind != null) {
    return rawKind.toClassKind();
  }
  throw ParseException.parsingFailed(
    message: "Can't deduct PJATK class kind '$kind'",
  );
}

/// Deduct groups from comma-separated string
List<String> deductGroups(String groups) {
  final rawGroups = groups.split(',');
  return rawGroups.map((g) => g.trim()).toList();
}

/// Deduct time range with timezone conversion (Warsaw → UTC)
(DateTime, DateTime) deductRange(PjatkClass pjatkClass) {
  // Parse date and times
  final dateFormat = DateFormat('dd.MM.yyyy');
  final timeFormat = DateFormat('HH:mm:ss');

  final date = dateFormat.parse(pjatkClass.date);
  final beginTime = timeFormat.parse(pjatkClass.from);
  final endTime = timeFormat.parse(pjatkClass.to);

  // Create DateTime in Warsaw timezone
  final warsaw = tz.getLocation('Europe/Warsaw');

  final datetimeBegin = DateTime(
    date.year,
    date.month,
    date.day,
    beginTime.hour,
    beginTime.minute,
    beginTime.second,
  );

  final datetimeEnd = DateTime(
    date.year,
    date.month,
    date.day,
    endTime.hour,
    endTime.minute,
    endTime.second,
  );

  final utcBegin = tz.TZDateTime.from(datetimeBegin, warsaw).toUtc();
  final utcEnd = tz.TZDateTime.from(datetimeEnd, warsaw).toUtc();

  return (utcBegin, utcEnd);
}

/// Deduct class place (online or on-site)
ClassPlace deductPlace(PjatkClass pjatkClass) {
  if (pjatkClass.isOnline) {
    return const ClassPlace.online();
  } else {
    return ClassPlace.onSite(room: pjatkClass.room);
  }
}

/// Transform raw PjatkClass to structured Class
ScheduledClass deductAll(PjatkClass item) {
  final (start, end) = deductRange(item);
  return ScheduledClass(
    classId: item.id.replaceAll(';z', ''),
    name: item.name,
    code: item.code,
    kind: deductKind(item.kind),
    lecturer: item.lecturer,
    start: start,
    end: end,
    place: deductPlace(item),
    groups: deductGroups(item.groups),
  );
}

/// Transform multiple raw classes
List<ScheduledClass> deductMulti(Iterable<PjatkClass> items) {
  return items.map(deductAll).toList();
}
