import 'package:pjatk_core/parsing/parsers/pjatk_parser.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  setUpAll(() {
    // Initialize timezone database
    tz.initializeTimeZones();
  });

  group('PjatkParser', () {
    late PjatkParser parser;

    setUp(() {
      parser = PjatkParser("https://planzajec.pjwstk.edu.pl/PlanOgolny.aspx");
    });

    test(
      'parseDay returns classes for today',
      () async {
        final classes = await parser.parseDay(DateTime.now());

        expect(classes, isA<List>());

        // If there are classes, verify their structure
        for (final classItem in classes) {
          expect(classItem.classId, isNotEmpty);
          expect(classItem.name, isNotEmpty);
          expect(classItem.code, isNotEmpty);
          expect(classItem.lecturer, isNotEmpty);
          expect(classItem.groups, isNotEmpty);
          expect(classItem.start.isBefore(classItem.end), isTrue);
        }
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'parseDay handles specific date',
      () async {
        final testDate = DateTime.now();
        final classes = await parser.parseDay(testDate);

        expect(classes, isA<List>());

        // If there are classes on this date, verify they're for the correct date
        for (final classItem in classes) {
          final classDate = classItem.start;
          expect(classDate.year, testDate.year);
          expect(classDate.month, testDate.month);
          expect(classDate.day, testDate.day);
        }
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'parser can handle multiple sequential requests',
      () async {
        // Test that the parser maintains state correctly across requests
        final today = DateTime.now();
        final tomorrow = today.add(const Duration(days: 1));

        final classesToday = await parser.parseDay(today);
        final classesTomorrow = await parser.parseDay(tomorrow);

        expect(classesToday, isA<List>());
        expect(classesTomorrow, isA<List>());
      },
      timeout: const Timeout(Duration(seconds: 120)),
    );
  });
}
