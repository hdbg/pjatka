import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/screen.dart';

void main() {
  group('SettingsPane', () {
    testWidgets('shows empty state when no setting is selected',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(body: SettingsPane()),
          ),
        ),
      );

      expect(find.text('No Setting Selected'), findsOneWidget);
      expect(
        find.text('Select a setting from the list to view its options'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.settings_suggest), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });
  });

  group('settingsDestination', () {
    test('has correct label and tooltip', () {
      expect(settingsDestination.label, 'Settings');
      expect(settingsDestination.tooltip, 'App Settings');
    });

    test('has main builders for all breakpoints', () {
      expect(settingsDestination.main.buildSmall, isNotNull);
      expect(settingsDestination.main.build, isNotNull);
      expect(settingsDestination.main.buildMediumLarge, isNotNull);
      expect(settingsDestination.main.buildLarge, isNotNull);
      expect(settingsDestination.main.buildExtraLarge, isNotNull);
    });

    test('has secondary builders for non-small breakpoints', () {
      expect(settingsDestination.secondary, isNotNull);
      expect(settingsDestination.secondary!.build, isNotNull);
      expect(settingsDestination.secondary!.buildMediumLarge, isNotNull);
      expect(settingsDestination.secondary!.buildLarge, isNotNull);
      expect(settingsDestination.secondary!.buildExtraLarge, isNotNull);
    });
  });

  group('allSettings', () {
    test('contains expected settings', () {
      expect(allSettings.length, 3);
      expect(allSettings.map((s) => s.title), containsAll(['Groups', 'Parser Range', 'Debug']));
    });

    test('each setting has required fields', () {
      for (final setting in allSettings) {
        expect(setting.title, isNotEmpty);
        expect(setting.description, isNotEmpty);
        expect(setting.builder, isNotNull);
      }
    });
  });
}
