import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:pjatka/features/parsing/parsers/class_deductor.dart';

void main() {
  setUpAll(() {
    // Initialize timezone database
    tz.initializeTimeZones();
  });

  group('ClassDeductor', () {
    group('deductKind', () {
      test('parses "Wykład" as lecture', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(deductKind(pjatkClass), ClassKind.lecture);
      });

      test('parses "Lektorat" as lecture', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Lektorat',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(deductKind(pjatkClass), ClassKind.lecture);
      });

      test('parses "Ćwiczenia" as seminar', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Ćwiczenia',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(deductKind(pjatkClass), ClassKind.seminar);
      });

      test('parses "Internet - ćwiczenia" as seminar', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Internet - ćwiczenia',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(deductKind(pjatkClass), ClassKind.seminar);
      });

      test('parses "Projekt dyplomowy" as diplomaThesis', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Projekt dyplomowy',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(deductKind(pjatkClass), ClassKind.diplomaThesis);
      });

      test('throws for unknown kind', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Unknown Type',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        expect(() => deductKind(pjatkClass), throwsException);
      });
    });

    group('deductGroups', () {
      test('splits comma-separated groups', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1, WI2, WI3',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        final groups = deductGroups(pjatkClass);

        expect(groups.length, 3);
        expect(groups[0], 'WI1');
        expect(groups[1], 'WI2');
        expect(groups[2], 'WI3');
      });

      test('trims whitespace from group codes', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: '  WI1  ,  WI2  ',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        final groups = deductGroups(pjatkClass);

        expect(groups[0], 'WI1');
        expect(groups[1], 'WI2');
      });

      test('handles single group', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        final groups = deductGroups(pjatkClass);

        expect(groups.length, 1);
        expect(groups[0], 'WI1');
      });
    });

    group('deductPlace', () {
      test('returns online when isOnline is true', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: true,
        );

        final place = deductPlace(pjatkClass);

        expect(place, isA<ClassPlaceOnline>());
      });

      test('returns onSite with room when isOnline is false', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '01.01.2024',
          isOnline: false,
        );

        final place = deductPlace(pjatkClass);

        expect(place, isA<ClassPlaceOnSite>());
        place.when(
          online: () => fail('Should be onSite'),
          onSite: (room) => expect(room, '101'),
        );
      });
    });

    group('deductRange', () {
      test('converts Warsaw time to UTC', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '15.06.2024',
          isOnline: false,
        );

        final (start, end) = deductRange(pjatkClass);

        expect(start.hour, 8);
        expect(end.hour, 9);
        expect(end.minute, 30);
      });

      test('handles winter time (UTC+1)', () {
        final pjatkClass = PjatkClass(
          id: 'test',
          name: 'Test Class',
          code: 'TEST',
          kind: 'Wykład',
          groups: 'WI1',
          lecturer: 'Test Lecturer',
          room: '101',
          from: '10:00:00',
          to: '11:30:00',
          date: '15.01.2024',
          isOnline: false,
        );

        final (start, end) = deductRange(pjatkClass);

        // In winter (January), Warsaw is UTC+1
        // So 10:00 Warsaw = 09:00 UTC
        expect(start.hour, 9);
        expect(end.hour, 10);
        expect(end.minute, 30);
      });
    });

    group('deductAll', () {
      test('transforms PjatkClass to Class correctly', () {
        final pjatkClass = PjatkClass(
          id: 'test-id;z',
          name: 'Test Class Name',
          code: 'TEST123',
          kind: 'Wykład',
          groups: 'WI1, WI2',
          lecturer: 'Dr. Test Lecturer',
          room: 'A101',
          from: '10:00:00',
          to: '11:30:00',
          date: '15.06.2024',
          isOnline: false,
        );

        final result = deductAll(pjatkClass);

        expect(result.classId, 'test-id');
        expect(result.name, 'Test Class Name');
        expect(result.code, 'TEST123');
        expect(result.kind, ClassKind.lecture);
        expect(result.lecturer, 'Dr. Test Lecturer');
        expect(result.groups.length, 2);
        expect(result.place, isA<ClassPlaceOnSite>());
      });
    });

    group('deductMulti', () {
      test('transforms multiple classes', () {
        final classes = [
          PjatkClass(
            id: 'test1;z',
            name: 'Class 1',
            code: 'TEST1',
            kind: 'Wykład',
            groups: 'WI1',
            lecturer: 'Lecturer 1',
            room: '101',
            from: '10:00:00',
            to: '11:30:00',
            date: '15.06.2024',
            isOnline: false,
          ),
          PjatkClass(
            id: 'test2;z',
            name: 'Class 2',
            code: 'TEST2',
            kind: 'Ćwiczenia',
            groups: 'WI2',
            lecturer: 'Lecturer 2',
            room: '102',
            from: '12:00:00',
            to: '13:30:00',
            date: '15.06.2024',
            isOnline: true,
          ),
        ];

        final results = deductMulti(classes);

        expect(results.length, 2);
        expect(results[0].classId, 'test1');
        expect(results[0].kind, ClassKind.lecture);
        expect(results[1].classId, 'test2');
        expect(results[1].kind, ClassKind.seminar);
        expect(results[1].place, isA<ClassPlaceOnline>());
      });
    });
  });
}
