import 'package:pjatka/features/schedule/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';
import '../../database/database.dart';
import '../data/schedule_dao.dart';
import '../../../utils.dart';

part 'schedule_providers.g.dart';

@riverpod
PjatkParser parser(Ref ref) {
  return PjatkParser();
}

@riverpod
ScheduleDao scheduleDao(Ref ref) {
  return ScheduleDao(database);
}

@riverpod
Future<List<ScheduledClass>> classes(Ref ref, DateTime day) async {
  final dao = ref.watch(scheduleDaoProvider);
  final parser = ref.watch(parserProvider);

  final earliest = await dao.getEarliestUpdateForDate(day);

  talker.debug('Earliest update for ${day.toIso8601String()}: $earliest');

  if (earliest == null || DateTime.now().difference(earliest).inHours > 24) {
    talker.info(
      'No classes found for date or too late: ${day.toIso8601String()}',
    );

    final parsedClasses = await parser.parseDay(day);

    await dao.syncClasses(day, parsedClasses);

    return parsedClasses;
  }

  return dao.getMeetingsForDate(day);
}

@riverpod
Future<List<ScheduledClass>> todayClasses(Ref ref) {
  final today = DateTime.now();
  final day = DateTime(today.year, today.month, today.day);
  return ref.read(classesProvider(day).future);
}
