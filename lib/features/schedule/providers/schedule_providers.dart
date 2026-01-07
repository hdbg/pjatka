import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';
import '../database.dart';
import '../data/schedule_dao.dart';
import '../../../logging.dart';

part 'schedule_providers.g.dart';

/// Provider for the parser singleton instance
@riverpod
PjatkParser parser(Ref ref) {
  return PjatkParser();
}

/// Provider for the database instance
@riverpod
AppDatabase appDatabase(Ref ref) {
  return database; // Use existing global instance
}

/// Provider for the schedule DAO
@riverpod
ScheduleDao scheduleDao(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ScheduleDao(db);
}

/// Family provider for fetching classes by date with cache-first strategy
@riverpod
Future<List<Class>> classes(Ref ref, DateTime date) async {
  final dao = ref.watch(scheduleDaoProvider);

  try {
    // Step 1: Check database for date
    talker.debug('Checking database cache for date: ${date.toIso8601String()}');
    final cached = await dao.getMeetingsForDate(date);
    final oldestCheck = await dao.getOldestLastCheckedForDate(date);

    // Step 2: Determine if stale (1 hour threshold)
    final now = DateTime.now();
    final isStale = oldestCheck == null ||
        now.difference(oldestCheck).inHours >= 1;

    if (isStale) {
      talker.debug('Cache is stale or empty, fetching fresh data');
    } else {
      talker.debug('Cache is fresh (< 1 hour old)');
    }

    // Step 3: If fresh cache exists, return it
    if (!isStale && cached.isNotEmpty) {
      talker.info('Returning ${cached.length} classes from cache');
      return cached.map((m) => m.toClass()).toList();
    }

    // Step 4: Fetch fresh data from parser
    talker.info('Fetching fresh data from parser');
    final parser = ref.watch(parserProvider);

    try {
      final parsed = await parser.parseDay(date);

      // Step 5: Sync to database (with error handling)
      try {
        await dao.syncClassesForDate(date, parsed);
      } catch (e, stack) {
        talker.error('Failed to sync to database', e, stack);
        // Continue - we have data from parser
      }

      // Step 6: Return fresh data
      talker.info('Returning ${parsed.length} fresh classes from parser');
      return parsed;
    } catch (parseError, stack) {
      // If parser fails but we have stale cache, return it
      if (cached.isNotEmpty) {
        talker.warning(
          'Parser failed, returning ${cached.length} classes from stale cache',
          parseError,
          stack,
        );
        return cached.map((m) => m.toClass()).toList();
      }
      // No cache available, rethrow
      rethrow;
    }
  } catch (e, stack) {
    talker.error('Complete failure in classes provider', e, stack);
    rethrow;
  }
}

/// Provider for today's classes (convenience wrapper)
@riverpod
Future<List<Class>> todayClasses(Ref ref) {
  final today = DateTime.now();
  final normalized = DateTime(today.year, today.month, today.day);
  return ref.watch(classesProvider(normalized).future);
}
