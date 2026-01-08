import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';
import '../../database/database.dart';
import '../data/schedule_dao.dart';
import '../../../utils.dart';

part 'schedule_providers.g.dart';

DateTime _stripTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

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
      'No classes found for date or cache is too old: ${day.toIso8601String()}',
    );

    final parsedClasses = await parser.parseDay(day);

    await dao.syncClasses(day, parsedClasses);

    return parsedClasses;
  }

  return dao.getMeetingsForDate(day);
}

@riverpod
Future<List<ScheduledClass>> onlySelectedClasses(Ref ref, DateTime day) async {
  final settings = ref.watch(settingsProvider);
  final allClasses = await ref.watch(classesProvider(day).future);

  for (final group in settings.groups) {
    talker.debug('Filtering classes for group: $group');
  }

  talker.debug(settings);

  return allClasses
      .where(
        (classItem) =>
            settings.groups.any((group) => classItem.groups.contains(group)),
      )
      .toList();
}

@Riverpod(keepAlive: true)
class Schedule extends _$Schedule {
  @override
  Future<Map<DateTime, List<ScheduledClass>>> build() async {
    final today = DateTime.now();
    final todayClasses = await ref.read(onlySelectedClassesProvider(today).future);

    return {_stripTime(today): todayClasses};
  }

  Future<List<ScheduledClass>> getClassesForDate(DateTime date) async {
    final additional = await ref.read(onlySelectedClassesProvider(date).future);

    state = await AsyncValue.guard(() async {
      final currentData = await state.value ?? {};
      final classes = additional;
      final strippedDate = _stripTime(date);
      final updatedData = Map<DateTime, List<ScheduledClass>>.from(currentData);
      updatedData[strippedDate] = classes;
      return updatedData;
    });

    return additional;
  }
}
