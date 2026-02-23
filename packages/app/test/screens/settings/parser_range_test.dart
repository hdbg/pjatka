import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/settings/parser_range.dart';

void main() {
  group('ParserRangeSettings', () {
    testWidgets('shows header with title and description', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const ParserRangeSettings(),
          ),
        ),
      );

      expect(find.text('Parser Range'), findsOneWidget);
      expect(
        find.text('Configure the date range for schedule parsing'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.date_range), findsOneWidget);
    });

    testWidgets('shows min and max offset fields', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const ParserRangeSettings(),
          ),
        ),
      );

      expect(find.text('Minimum Days Offset'), findsOneWidget);
      expect(find.text('Maximum Days Offset'), findsOneWidget);
      expect(
        find.text('How many days in the past to fetch schedules'),
        findsOneWidget,
      );
      expect(
        find.text('How many days in the future to fetch schedules'),
        findsOneWidget,
      );
    });

    testWidgets('displays default offset values', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const ParserRangeSettings(),
          ),
        ),
      );

      // Default values from SettingsState: minDateDaysOffset=7, maxDateDaysOffset=30
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(2));

      final minField = tester.widget<TextField>(textFields.first);
      expect(minField.controller?.text, '7');

      final maxField = tester.widget<TextField>(textFields.last);
      expect(maxField.controller?.text, '30');
    });

    testWidgets('displays custom offset values', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(
              SettingsState(minDateDaysOffset: 14, maxDateDaysOffset: 60),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const ParserRangeSettings(),
          ),
        ),
      );

      final textFields = find.byType(TextField);
      final minField = tester.widget<TextField>(textFields.first);
      expect(minField.controller?.text, '14');

      final maxField = tester.widget<TextField>(textFields.last);
      expect(maxField.controller?.text, '60');
    });

    testWidgets('shows info card', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const ParserRangeSettings(),
          ),
        ),
      );

      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(
        find.textContaining('These settings control the date range'),
        findsOneWidget,
      );
    });
  });

  group('parserRangeSetting', () {
    test('has correct title and icon', () {
      expect(parserRangeSetting.title, 'Parser Range');
      expect(parserRangeSetting.icon, Icons.date_range);
      expect(parserRangeSetting.description, 'Configure schedule date range');
    });
  });
}
