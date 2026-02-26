import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/home.dart';

void main() {
  group('Switcher', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Switcher(child: Text('Hello')),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('renders with null child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Switcher(child: null),
        ),
      );

      expect(find.byType(Switcher), findsOneWidget);
      expect(find.byType(AnimatedSwitcher), findsOneWidget);
    });

    testWidgets('uses FadeTransition for animation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Switcher(child: Text('Fade me')),
        ),
      );

      expect(find.byType(FadeTransition), findsOneWidget);
    });

    testWidgets('animates when child changes', (tester) async {
      final childNotifier = ValueNotifier<Widget>(
        const Text('First', key: ValueKey('first')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ValueListenableBuilder<Widget>(
            valueListenable: childNotifier,
            builder: (context, child, _) => Switcher(child: child),
          ),
        ),
      );

      expect(find.text('First'), findsOneWidget);

      childNotifier.value =
          const Text('Second', key: ValueKey('second'));
      await tester.pump();

      // Both old and new widgets should be present during transition
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);

      // After animation completes, only the new widget should remain
      await tester.pumpAndSettle();
      expect(find.text('First'), findsNothing);
      expect(find.text('Second'), findsOneWidget);
    });
  });

  group('patchAnimated', () {
    test('returns null when input is null', () {
      expect(patchAnimated(null), isNull);
    });

    test('returns a builder that wraps with Switcher', () {
      final builder = patchAnimated(
        (context) => const Text('Wrapped'),
      );
      expect(builder, isNotNull);
    });
  });

  group('Destination', () {
    test('creates with required fields', () {
      final destination = Destination(
        label: 'Test',
        icon: const Icon(Icons.home),
        main: AdaptiveBuilders(),
      );

      expect(destination.label, 'Test');
      expect(destination.secondary, isNull);
      expect(destination.tooltip, isNull);
    });

    test('creates with all fields', () {
      final destination = Destination(
        label: 'Test',
        icon: const Icon(Icons.home),
        selectedIcon: const Icon(Icons.home_outlined),
        main: AdaptiveBuilders(),
        secondary: AdaptiveBuilders(),
        tooltip: 'Test tooltip',
      );

      expect(destination.label, 'Test');
      expect(destination.selectedIcon, isNotNull);
      expect(destination.secondary, isNotNull);
      expect(destination.tooltip, 'Test tooltip');
    });
  });
}
