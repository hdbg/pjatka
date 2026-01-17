import 'dart:async';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/parsing/parsers/class_deductor.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/screens/groups_retriever/ical_inductor/form.dart';
import 'package:pjatka/screens/groups_retriever/ical_inductor/ical_parser.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';

const _examMarker = 'Egzamin';

class _CandidateClass {
  final String code;
  final ClassKind kind;
  final String? room;

  final DateTime from;
  final DateTime to;

  _CandidateClass._({
    required this.code,
    required this.kind,
    required this.room,
    required this.from,
    required this.to,
  });

  @override
  String toString() =>
      '_CandidateClass(code: $code, kind: $kind, room: $room, from: $from, to: $to)';

  /// There is basically two formats in iCalendar file:
  /// - WSI wykład s. A/1
  /// - Egzamin Wprowadzenie do systemów informacyjnych  Gago Piotr s.B/217 egzamin s. B/217
  /// We are ignoring exam entries for now
  factory _CandidateClass.fromEvent(Event event) {
    final summaryElements = event.summary.trim().split(' ');

    if (summaryElements.first.toLowerCase() == _examMarker.toLowerCase()) {
      throw FormatException('Exam entry');
    }

    if (summaryElements.length < 4) {
      throw FormatException('Unexpected summary format: ${event.summary}');
    }

    final code = summaryElements.first;
    final kindString = summaryElements[1];

    // Third index because there is also 's.' before room and dart sublists are begin-inclusive
    // WSI wykład s. A/1
    // 0^  1^     2^ 3^
    final room = summaryElements.sublist(3).join(' ');

    final from = event.start;
    final to = event.end;

    for (final kind in PjatkRawKind.values) {
      for (final displayName in kind.displayNames) {
        if (displayName.toLowerCase() == kindString.toLowerCase()) {
          return _CandidateClass._(
            code: code,
            kind: kind.toClassKind(),
            room: room,
            from: from,
            to: to,
          );
        }
      }
    }

    throw FormatException('Unknown class kind: $kindString');
  }
}

Future<Set<String>> queryGroupsFromCandidate(_CandidateClass candidate) async {
  final groupsQuery =
      scheduleDb.selectOnly(scheduleDb.group, distinct: true).join([
          innerJoin(
            scheduleDb.classGroup,
            scheduleDb.classGroup.groupId.equalsExp(scheduleDb.group.id),
          ),
          innerJoin(
            scheduleDb.classAppointment,
            scheduleDb.classGroup.appointmentId.equalsExp(
              scheduleDb.classAppointment.id,
            ),
          ),
          innerJoin(
            scheduleDb.subject,
            scheduleDb.subject.id.equalsExp(
              scheduleDb.classAppointment.subjectId,
            ),
          ),
        ])
        ..addColumns([scheduleDb.group.name])
        ..where(
          scheduleDb.subject.code.equals(candidate.code.trim()) &
              scheduleDb.subject.kind.equalsValue(candidate.kind) &

              scheduleDb.classAppointment.startTime.year.equals(candidate.from.year) &
              scheduleDb.classAppointment.startTime.month.equals(candidate.from.month) &
              scheduleDb.classAppointment.startTime.day.equals(candidate.from.day) &
              scheduleDb.classAppointment.startTime.hour.equals(candidate.from.hour) &
              scheduleDb.classAppointment.startTime.minute.equals(candidate.from.minute) &

              scheduleDb.classAppointment.location.equals(
                candidate.room?.trim() ?? '',
              ),
        );

  final groups = await groupsQuery.get();

  return groups
      .map((e) => e.read(scheduleDb.group.name) ?? '')
      .where((e) => e.isNotEmpty)
      .toSet();
}

/// This function works by probabilstic calculation which groups user is in by comparing time, subject and room to the database
Future<List<Set<String>>> _parseIcalAndQueryGroups(String icalData) async {
  final candidateGroupSets = <Set<String>>[];
  final calendar = IcsParser.parse(icalData);

  for (final child in calendar.events) {
    try {
      final candidateClass = _CandidateClass.fromEvent(child);
      final candidateGroups = await queryGroupsFromCandidate(candidateClass);

      if (candidateGroups.isEmpty) {
        talker.warning(
          'No groups found for event: ${child.summary} at ${child.start}: ${candidateClass.toString()}',
        );
        continue;
      }

      candidateGroupSets.add(candidateGroups);
    } on FormatException catch (e) {
      talker.warning('Failed to parse event: ${e.message}');
    }
  }

  return candidateGroupSets;
}

@visibleForTesting
Set<String> resolveGroupsFromSets(List<Set<String>> candidateGroupSets) {

  talker.debug('Resolving groups from candidate sets: $candidateGroupSets');

  final groups = <String>{};
  final ambigiousGroups = [<String>{}];

  for (final candidateGroups in candidateGroupSets) {
    if (candidateGroups.length > 1) {
      // Multiple groups found, store separately for further analysis
      ambigiousGroups.add(candidateGroups);
    } else {
      groups.addAll(candidateGroups);
    }
  }

  // Analyze ambigious groups
  // If groups appears in multiple ambigious sets, it's likely the user is in that group
  // Or if one of the group in one of the ambgigious is confirmed, then we skip it
  for (final ambigiousSet in ambigiousGroups) {
    for (final group in ambigiousSet) {
      if (groups.contains(group)) {
        // Already confirmed
        break;
      }

      var appearsInAll = true;
      for (final otherSet in ambigiousGroups) {
        if (!otherSet.contains(group)) {
          appearsInAll = false;
          break;
        }
      }

      if (appearsInAll) {
        groups.add(group);
        break;
      }
    }
  }

  return groups;
}

Future<Set<String>> resolveGroups(String icalData) async {
  final candidateGroupSets = await _parseIcalAndQueryGroups(icalData);
  return resolveGroupsFromSets(candidateGroupSets);
}

Future<void> showIcalInductor(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Import from iCal')),
        body: Padding(
          padding: EdgeInsets.all(2.w),
          child:  ICalInductorForm(completer: Completer(),),
        ),
      ),
    ),
  );
}
