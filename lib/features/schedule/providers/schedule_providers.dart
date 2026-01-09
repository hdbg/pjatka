import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';
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

final classesProvider = StreamProvider<List<ScheduledClass>>((ref) {
  final settings = ref.watch(settingsProvider);

  return ScheduleDao.watchClasses(settings);
});

@Riverpod(keepAlive: true)
Future<void> globalLoader(Ref ref) async {
  final parser = ref.read(parserProvider);
  final settings = await ref.watch(settingsProvider);

  final today = DateTime.now();

  final initialDate = today.subtract(
    Duration(days: settings.minDateDaysOffset),
  );
  var totalDelta = settings.maxDateDaysOffset + settings.minDateDaysOffset;
  for (var i = 0; i <= totalDelta; i++) {
    final date = initialDate.add(Duration(days: i));

    final earliestUpdate = await ScheduleDao.getEarliestUpdateForDate(date);
    if (earliestUpdate != null) {
      final hoursSinceUpdate = today.difference(earliestUpdate).inHours;
      if (hoursSinceUpdate < settings.cacheTTLHours) {
        talker.debug(
          'Skipping schedule load for ${_stripTime(date)}; last update was $hoursSinceUpdate hours ago',
        );
        continue;
      }
    }

    final parsedDays = await parser.parseDay(_stripTime(date));


    await ScheduleDao.syncClasses(date, parsedDays);
  }
}
