import 'package:pjatk_core/database/models.dart';

/// Represents a class appointment candidate extracted from a schedule source.
class CandidateClass {
  final String code;
  final ClassKind kind;
  final String? room;

  final DateTime from;
  final DateTime to;

  const CandidateClass({
    required this.code,
    required this.kind,
    required this.room,
    required this.from,
    required this.to,
  });

  @override
  String toString() =>
      'CandidateClass(code: $code, kind: $kind, room: $room, from: $from, to: $to)';
}

/// Abstract base class for schedule inductors.
///
/// An inductor is responsible for parsing raw schedule data from a
/// specific format and extracting [CandidateClass] objects that can
/// then be matched against the local database to infer the user's
/// groups.
abstract class ScheduleInductor {
  /// Parses [data] and returns all extractable [CandidateClass] instances.
  ///
  /// Entries that cannot be parsed (e.g. unsupported event types or
  /// malformed records) must be silently skipped rather than throwing.
  List<CandidateClass> extractCandidates(String data);
}
