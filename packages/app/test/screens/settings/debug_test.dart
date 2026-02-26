import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/settings/debug.dart';

void main() {
  group('Debug', () {
    testWidgets('shows developer tools header', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(body: Debug()),
          ),
        ),
      );

      expect(find.text('Developer Tools'), findsOneWidget);
      expect(find.text('Diagnostic & Recovery tools'), findsOneWidget);
      expect(find.byIcon(Icons.developer_mode), findsOneWidget);
    });

    testWidgets('shows all debug action cards', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(body: Debug()),
          ),
        ),
      );

      expect(find.text('Application Logs'), findsOneWidget);
      expect(find.text('Trigger Group Retriever'), findsOneWidget);
      expect(find.text('View Database'), findsOneWidget);
      expect(find.text('Restart Onboarding'), findsOneWidget);
      expect(find.text('Clear Database'), findsOneWidget);
    });

    testWidgets('shows warning notice', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(body: Debug()),
          ),
        ),
      );

      expect(
        find.text('These tools are for development purposes only'),
        findsOneWidget,
      );
    });
  });

  group('debugSetting', () {
    test('has correct title and icon', () {
      expect(debugSetting.title, 'Debug');
      expect(debugSetting.icon, Icons.bug_report);
      expect(debugSetting.description, 'Debugging options and information');
    });
  });
}
