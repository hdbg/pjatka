import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';
import '../../database/dao/schedule_dao.dart';
import '../../../utils.dart';

part 'schedule_providers.g.dart';

DateTime _stripTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

@riverpod
PjatkParser parser(Ref ref) {
  return PjatkParser();
}

final userClassesProvider = StreamProvider<List<ScheduledClass>>((ref) {
  final settings = ref.watch(settingsProvider);

  return ScheduleDao.watchClasses(settings);
});
@Riverpod(keepAlive: true)
Future<void> globalLoader(Ref ref) async {
  final parser = ref.read(parserProvider);
  final settings = await ref.watch(settingsProvider);

  final today = _stripTime(DateTime.now());


  final parseOneDay = (date) async {
    final earliestUpdate = await ScheduleDao.getEarliestUpdateForDate(date);
    if (earliestUpdate != null) {
      final hoursSinceUpdate = today.difference(earliestUpdate).inHours;
      if (hoursSinceUpdate.abs() < settings.cacheTTLHours) {
        talker.debug(
          'Skipping schedule load for ${date}; last update was $hoursSinceUpdate hours ago',
        );
        return;
      }
    }

    final parsedDays = await parser.parseDay(date);

    if (parsedDays.isEmpty) {
      return;
    }

    try {
      await ScheduleDao.syncClasses(date, parsedDays);
    } catch (e, stackTrace) {
      talker.handle(
        e,
        stackTrace,
        'Error syncing classes for date ${date.toIso8601String()}',
      );
    }
  };

  await parseOneDay(today);

  // first we load from today onwards to optimize for user experience
  for (var i = 0; i <= settings.maxDateDaysOffset; i++) {
    final date = today.add(Duration(days: i));

    await parseOneDay(date);
  }

  // then we load the past days
  for (var i = 1; i <= settings.minDateDaysOffset; i++) {
    final date = today.subtract(Duration(days: i));
    await parseOneDay(date);
  }
}
