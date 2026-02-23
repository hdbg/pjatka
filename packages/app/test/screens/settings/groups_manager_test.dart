import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';

void main() {
  group('GroupsManager', () {
    testWidgets('shows empty state when no groups exist', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const GroupsManager(),
          ),
        ),
      );

      expect(find.text('Manage Groups'), findsOneWidget);
      expect(find.text('No Groups Yet'), findsOneWidget);
      expect(
        find.text('Add first group to show schedule for it'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.group_add), findsWidgets);
    });

    testWidgets('shows group list when groups exist', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(
              SettingsState(groups: {'WIs I.2', 'WIs I.3'}),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const GroupsManager(),
          ),
        ),
      );

      expect(find.text('WIs I.2'), findsOneWidget);
      expect(find.text('WIs I.3'), findsOneWidget);
      expect(find.text('No Groups Yet'), findsNothing);
    });

    testWidgets('shows header with correct title and description',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const GroupsManager(),
          ),
        ),
      );

      expect(find.text('Manage Groups'), findsOneWidget);
      expect(
        find.text('Manage which study groups you want to follow'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.groups_2), findsOneWidget);
    });

    testWidgets('shows add group input field', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(SettingsState()),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: const GroupsManager(),
          ),
        ),
      );

      expect(find.text('Group name'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });

  group('GroupTile', () {
    testWidgets('shows group name with checkbox', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(
              SettingsState(groups: {'WIs I.2'}),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: ListView(
                children: const [GroupTile(group: 'WIs I.2')],
              ),
            ),
          ),
        ),
      );

      expect(find.text('WIs I.2'), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsOneWidget);
    });

    testWidgets('checkbox toggles selection on tap', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(
              SettingsState(groups: {'WIs I.2'}),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: ListView(
                children: const [GroupTile(group: 'WIs I.2')],
              ),
            ),
          ),
        ),
      );

      // Checkbox should be unchecked initially
      final checkbox =
          tester.widget<CheckboxListTile>(find.byType(CheckboxListTile));
      expect(checkbox.value, false);

      // Tap the checkbox to select
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pump();

      // Now it should be checked
      final updatedCheckbox =
          tester.widget<CheckboxListTile>(find.byType(CheckboxListTile));
      expect(updatedCheckbox.value, true);
    });
  });

  group('groupSetting', () {
    test('has correct title and icon', () {
      expect(groupSetting.title, 'Groups');
      expect(groupSetting.icon, Icons.group);
      expect(groupSetting.description, 'Manage your study groups');
    });
  });

  group('showDeleteDialog', () {
    testWidgets('displays confirmation dialog with correct count',
        (tester) async {
      late WidgetRef capturedRef;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(
              SettingsState(groups: {'G1', 'G2'}),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Consumer(
              builder: (context, ref, _) {
                capturedRef = ref;
                return Scaffold(
                  body: ElevatedButton(
                    onPressed: () =>
                        showDeleteDialog(ref, context, {'G1', 'G2'}),
                    child: const Text('Delete'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(find.text('Delete selected groups?'), findsOneWidget);
      expect(
        find.text('This will permanently remove 2 groups.'),
        findsOneWidget,
      );
      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
