import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:talker/talker.dart';

class ReconcilerConfig {
  final int minDateDaysOffset;
  final int maxDayOffset;
  final int cacheTTLHours;
  const ReconcilerConfig({
    this.minDateDaysOffset = 7,
    this.maxDayOffset = 30,
    this.cacheTTLHours = 24,
  });
}

abstract interface class Parser {
  Future<List<ScheduledClass>> parseDay(DateTime date);
}

class ScheduleReconciler {
  final Talker talker;
  final ScheduleDao dao;
  final ReconcilerConfig config;
  final Parser parser;

  ScheduleReconciler({
    required this.dao,

    required this.config,
    required this.talker, required this.parser,
  });

  Future<void> _parseOneDay(DateTime date) async {
    final earliestUpdate = await dao.getEarliestUpdateForDate(date);
    if (earliestUpdate != null) {
      final hoursSinceUpdate = date.difference(earliestUpdate).inHours;
      if (hoursSinceUpdate.abs() < config.cacheTTLHours) {
        talker.debug(
          'Skipping schedule load for $date; last update was $hoursSinceUpdate hours ago',
        );
        return;
      }
    }

    final parsedDays = await parser.parseDay(date);

    if (parsedDays.isEmpty) {
      return;
    }

    try {
      await dao.syncClasses(date, parsedDays);
    } catch (e, stackTrace) {
      talker.handle(
        e,
        stackTrace,
        'Error syncing classes for date ${date.toIso8601String()}',
      );
    }
  }

  Future<void> reconcileOnce() async {
    final today = _stripTime(DateTime.now());

    await _parseOneDay(today);

    // first we load from today onwards to optimize for user experience
    for (var i = 0; i <= config.maxDayOffset; i++) {
      final date = today.add(Duration(days: i));

      await _parseOneDay(date);
    }

    // then we load the past days
    for (var i = 1; i <= config.minDateDaysOffset; i++) {
      final date = today.subtract(Duration(days: i));
      await _parseOneDay(date);
    }
  }
}

DateTime _stripTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
