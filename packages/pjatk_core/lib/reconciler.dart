import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:talker/talker.dart';

class ReconcilerConfig {
  static const defaultCacheTTLMinutes = 1440;
  static const defaultSoonDaysThreshold = 3;

  final int minDateDaysOffset;
  final int maxDayOffset;
  final int cacheTTLMinutes;
  final int soonDaysThreshold;
  const ReconcilerConfig({
    this.minDateDaysOffset = 7,
    this.maxDayOffset = 30,
    this.cacheTTLMinutes = defaultCacheTTLMinutes,
    this.soonDaysThreshold = defaultSoonDaysThreshold,
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
    required this.talker,
    required this.parser,
  });

  Future<void> _parseOneDay(DateTime date, {required DateTime now}) async {
    final nextParseTs = await dao.getNextParseTs(date);
    if (nextParseTs != null && now.isBefore(nextParseTs)) {
      talker.debug('Skipping $date; next parse at $nextParseTs');
      return;
    }

    final parsedDays = await parser.parseDay(date);

    final newNextParseTs = _computeNextParseTs(date, now: now);

    try {
      await dao.syncClasses(date, parsedDays, nextParseTs: newNextParseTs);
    } catch (e, stackTrace) {
      talker.handle(
        e,
        stackTrace,
        'Error syncing classes for date ${date.toIso8601String()}',
      );
    }
  }

  DateTime _computeNextParseTs(DateTime date, {required DateTime now}) {
    final today = _stripTime(now);
    final daysFromToday = date.difference(today).inDays;
    // Past days and days within soonDaysThreshold: use flat cacheTTLMinutes
    if (daysFromToday <= config.soonDaysThreshold) {
      return now.add(Duration(minutes: config.cacheTTLMinutes));
    }
    // Distant days: spread reparse proportionally
    return now.add(Duration(minutes: daysFromToday * config.cacheTTLMinutes));
  }

  /// Invalidates cached days whose [DayInfo.nextParseTs] is farther in the
  /// future than the current [ReconcilerConfig.cacheTTLMinutes] allows.
  ///
  /// Call this when [cacheTTLMinutes] has been reduced so that affected days
  /// are reparsed promptly under the new TTL.
  Future<void> invalidateCachedDays({required DateTime now}) async {
    final threshold = now.add(Duration(minutes: config.cacheTTLMinutes));
    await dao.invalidateDaysBeyondTs(threshold);
  }

  Future<void> reconcileOnce({DateTime? now}) async {
    final effectiveNow = now ?? DateTime.now();
    final today = _stripTime(effectiveNow);

    await _parseOneDay(today, now: effectiveNow);

    // first we load from today onwards to optimize for user experience
    for (var i = 1; i <= config.maxDayOffset; i++) {
      final date = today.add(Duration(days: i));

      await _parseOneDay(date, now: effectiveNow);
    }

    // then we load the past days
    for (var i = 1; i <= config.minDateDaysOffset; i++) {
      final date = today.subtract(Duration(days: i));
      await _parseOneDay(date, now: effectiveNow);
    }
  }
}

DateTime _stripTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
