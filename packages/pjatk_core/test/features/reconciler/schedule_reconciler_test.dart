import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/database.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/reconciler.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<Parser>()])
import 'schedule_reconciler_test.mocks.dart';

/// Creates a [ScheduledClass] stub for the given [date].
ScheduledClass _classFor(DateTime date) {
  return ScheduledClass(
    classId: date.toIso8601String(),
    name: 'Class ${date.day}',
    code: 'TST${date.day}',
    kind: ClassKind.lecture,
    lecturer: 'Dr. Mock',
    start: date.add(const Duration(hours: 9)),
    end: date.add(const Duration(hours: 11)),
    place: const ClassPlace.onSite(room: 'A101'),
    groups: ['GR1'],
  );
}

ScheduleDatabase _createInMemoryDb() {
  return ScheduleDatabase(NativeDatabase.memory());
}

void main() {
  late ScheduleDatabase db;
  late ScheduleDao dao;
  late MockParser mockParser;
  late Talker talker;

  setUp(() {
    db = _createInMemoryDb();
    talker = Talker();
    dao = ScheduleDao(db, talker: talker);
    mockParser = MockParser();
  });

  tearDown(() async {
    await db.close();
  });

  /// Stubs [mockParser] to return 1 class per day for [today] + [maxDayOffset] days.
  void stubAllDays(DateTime today, {required int maxDayOffset}) {
    for (var i = 0; i <= maxDayOffset; i++) {
      final date = today.add(Duration(days: i));
      when(mockParser.parseDay(date))
          .thenAnswer((_) async => [_classFor(date)]);
    }
  }

  group('ScheduleReconciler', () {
    test('plain parsing for 7 days forward', () async {
      final now = DateTime(2026, 3, 1, 12, 0);
      final today = DateTime(2026, 3, 1);

      stubAllDays(today, maxDayOffset: 7);

      final reconciler = ScheduleReconciler(
        dao: dao,
        config: const ReconcilerConfig(
          maxDayOffset: 7,
          minDateDaysOffset: 0,
        ),
        parser: mockParser,
        talker: talker,
      );

      await reconciler.reconcileOnce(now: now);

      // Should have parsed today + 7 days forward = 8 days total
      for (var i = 0; i <= 7; i++) {
        final date = today.add(Duration(days: i));
        verify(mockParser.parseDay(date)).called(1);
      }

      // Verify classes are in the DB
      final classes = await dao
          .watchClasses(
            filters: WatchFilters(
              from: DateTime(2026, 3, 1),
              to: DateTime(2026, 3, 9),
            ),
          )
          .first;

      expect(classes.length, equals(8));

      for (final c in classes) {
        expect(c.lecturer, equals('Dr. Mock'));
        expect(c.groups, equals(['GR1']));
      }
    });

    test('reparse after time passes, skip within TTL', () async {
      final now1 = DateTime(2026, 3, 1, 12, 0);
      final today = DateTime(2026, 3, 1);
      const cacheTTL = 60; // 1 hour

      stubAllDays(today, maxDayOffset: 7);

      final reconciler = ScheduleReconciler(
        dao: dao,
        config: const ReconcilerConfig(
          maxDayOffset: 7,
          minDateDaysOffset: 0,
          cacheTTLMinutes: cacheTTL,
          soonDaysThreshold: 10, // all 7 days are "soon"
        ),
        parser: mockParser,
        talker: talker,
      );

      // First pass — parses all
      await reconciler.reconcileOnce(now: now1);
      for (var i = 0; i <= 7; i++) {
        verify(mockParser.parseDay(today.add(Duration(days: i)))).called(1);
      }

      // Second pass within TTL — should skip all
      clearInteractions(mockParser);
      await reconciler.reconcileOnce(
        now: now1.add(const Duration(minutes: 30)),
      );
      verifyNever(mockParser.parseDay(any));

      // Third pass after TTL expires — should reparse all
      clearInteractions(mockParser);
      final now2 = now1.add(const Duration(minutes: cacheTTL + 1));
      await reconciler.reconcileOnce(now: now2);
      for (var i = 0; i <= 7; i++) {
        verify(mockParser.parseDay(today.add(Duration(days: i)))).called(1);
      }
    });

    test(
      'soonThreshold: distant days have monotonically increasing, evenly-spaced reparse times',
      () async {
        final now = DateTime(2026, 3, 1, 12, 0);
        final today = DateTime(2026, 3, 1);
        const cacheTTL = 60;
        const soonThreshold = 2;

        stubAllDays(today, maxDayOffset: 7);

        final reconciler = ScheduleReconciler(
          dao: dao,
          config: const ReconcilerConfig(
            maxDayOffset: 7,
            minDateDaysOffset: 0,
            cacheTTLMinutes: cacheTTL,
            soonDaysThreshold: soonThreshold,
          ),
          parser: mockParser,
          talker: talker,
        );

        await reconciler.reconcileOnce(now: now);

        // Collect nextParseTs for distant days (beyond soonThreshold)
        final distantParseTimes = <DateTime>[];
        for (var i = soonThreshold + 1; i <= 7; i++) {
          final date = today.add(Duration(days: i));
          final ts = await dao.getNextParseTs(date);
          expect(ts, isNotNull, reason: 'Day +$i should have nextParseTs');
          distantParseTimes.add(ts!);
        }

        // Each successive distant day has nextParseTs further into the future
        for (var i = 1; i < distantParseTimes.length; i++) {
          expect(
            distantParseTimes[i].isAfter(distantParseTimes[i - 1]),
            isTrue,
            reason:
                'Distant day ${soonThreshold + 1 + i} should reparse later than day ${soonThreshold + i}',
          );
        }

        // Interval between consecutive distant days is constant
        final intervals = <int>[];
        for (var i = 1; i < distantParseTimes.length; i++) {
          intervals.add(
            distantParseTimes[i]
                .difference(distantParseTimes[i - 1])
                .inMinutes,
          );
        }

        final firstInterval = intervals.first;
        for (final interval in intervals) {
          expect(
            interval,
            equals(firstInterval),
            reason:
                'All distant-day reparse intervals should be equal ($firstInterval min)',
          );
        }

        // After flat cacheTTL, soon days should reparse but distant days should not
        clearInteractions(mockParser);
        final afterSoonTTL = now.add(const Duration(minutes: cacheTTL + 1));
        await reconciler.reconcileOnce(now: afterSoonTTL);

        for (var i = 0; i <= soonThreshold; i++) {
          verify(mockParser.parseDay(today.add(Duration(days: i)))).called(1);
        }
        for (var i = soonThreshold + 1; i <= 7; i++) {
          verifyNever(mockParser.parseDay(today.add(Duration(days: i))));
        }
      },
    );

    test('after 7-day time skip, new date range is parsed', () async {
      final now1 = DateTime(2026, 3, 1, 12, 0);
      final today1 = DateTime(2026, 3, 1);
      const cacheTTL = 60;

      // Stub days for first week (March 1–8)
      stubAllDays(today1, maxDayOffset: 7);

      final reconciler = ScheduleReconciler(
        dao: dao,
        config: const ReconcilerConfig(
          maxDayOffset: 7,
          minDateDaysOffset: 0,
          cacheTTLMinutes: cacheTTL,
          soonDaysThreshold: 3,
        ),
        parser: mockParser,
        talker: talker,
      );

      // First reconciliation: March 1–8
      await reconciler.reconcileOnce(now: now1);
      for (var i = 0; i <= 7; i++) {
        verify(mockParser.parseDay(today1.add(Duration(days: i)))).called(1);
      }

      // Skip 7 days forward
      final now2 = DateTime(2026, 3, 8, 12, 0);
      final today2 = DateTime(2026, 3, 8);

      // Stub days for second week (March 8–15)
      stubAllDays(today2, maxDayOffset: 7);

      clearInteractions(mockParser);
      await reconciler.reconcileOnce(now: now2);

      // March 8 was already parsed in the first run, but its nextParseTs
      // should have expired by now (7 days later), so it gets reparsed.
      // March 9–15 are entirely new and must be parsed.
      for (var i = 0; i <= 7; i++) {
        verify(mockParser.parseDay(today2.add(Duration(days: i)))).called(1);
      }

      // Verify new classes are in the DB
      final classes = await dao
          .watchClasses(
            filters: WatchFilters(
              from: DateTime(2026, 3, 8),
              to: DateTime(2026, 3, 16),
            ),
          )
          .first;

      expect(classes.length, equals(8));
    });
  });
}
