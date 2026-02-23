// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/src/adaptive_scaffold.dart';
import 'package:flutter_adaptive_scaffold/src/rail/drag_rail.dart';
import 'package:flutter_test/flutter_test.dart';

const List<NavigationRailDestination> _destinations =
    <NavigationRailDestination>[
  NavigationRailDestination(
    icon: Icon(Icons.home),
    label: Text('Home'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.account_circle),
    label: Text('Profile'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.settings),
    label: Text('Settings'),
  ),
];

/// Builds a simple test scaffold with a DragRail and a body side by side.
Widget _buildTestApp({
  bool extended = false,
  double collapsedWidth = 72,
  double expandedWidth = 200,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  ValueChanged<bool>? onExtendedChanged,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          DragRail(
            destinations: _destinations,
            collapsedWidth: collapsedWidth,
            expandedWidth: expandedWidth,
            extended: extended,
            onExtendedChanged: onExtendedChanged,
            padding: padding,
          ),
          const Expanded(
            child: ColoredBox(
              key: Key('body'),
              color: Colors.white,
              child: SizedBox.expand(),
            ),
          ),
        ],
      ),
    ),
  );
}

void main() {
  group('DragRail overlay behavior', () {
    testWidgets(
      'DragRail always consumes collapsed width for layout',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(extended: false));
        await tester.pumpAndSettle();

        // Find the DragRail's SizedBox (the OverlayPortal child)
        final dragRail = find.byType(DragRail);
        expect(dragRail, findsOneWidget);

        final railSize = tester.getSize(dragRail);
        expect(railSize.width, equals(72.0));
      },
    );

    testWidgets(
      'DragRail consumes collapsed width even when extended',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(extended: true));
        await tester.pumpAndSettle();

        final dragRail = find.byType(DragRail);
        expect(dragRail, findsOneWidget);

        // Layout width should still be collapsed width
        final railSize = tester.getSize(dragRail);
        expect(railSize.width, equals(72.0));
      },
    );

    testWidgets(
      'body content gets full remaining space regardless of rail extension',
      (WidgetTester tester) async {
        const double screenWidth = 800;
        const double collapsedWidth = 72;

        await tester.binding.setSurfaceSize(const Size(screenWidth, 600));

        // Test with collapsed rail
        await tester.pumpWidget(_buildTestApp(
          extended: false,
          collapsedWidth: collapsedWidth,
        ));
        await tester.pumpAndSettle();

        final bodyCollapsed = find.byKey(const Key('body'));
        final bodySizeCollapsed = tester.getSize(bodyCollapsed);

        // Test with extended rail
        await tester.pumpWidget(_buildTestApp(
          extended: true,
          collapsedWidth: collapsedWidth,
        ));
        await tester.pumpAndSettle();

        final bodyExtended = find.byKey(const Key('body'));
        final bodySizeExtended = tester.getSize(bodyExtended);

        // Body should have the same width in both cases since rail
        // always consumes collapsed width for layout
        expect(bodySizeCollapsed.width, equals(bodySizeExtended.width));

        // Reset surface size
        await tester.binding.setSurfaceSize(const Size(800, 600));
      },
    );

    testWidgets(
      'scrim overlay appears when rail is expanded',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(extended: true));
        await tester.pumpAndSettle();

        // The scrim should be present as a ColoredBox in the overlay
        // Find the GestureDetector wrapping the scrim
        final scrimFinder = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            // Scrim is black with some opacity (0.5 * progress)
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0;
          }
          return false;
        });

        expect(scrimFinder, findsOneWidget);
      },
    );

    testWidgets(
      'scrim opacity is tied to expand animation progress',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(extended: false));
        await tester.pumpAndSettle();

        // Initially no scrim (fully collapsed)
        final scrimFinder = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0;
          }
          return false;
        });
        expect(scrimFinder, findsNothing);

        // Start a drag to begin expansion
        final dragRail = find.byType(DragRail);
        final railCenter = tester.getCenter(dragRail);

        // Begin drag
        final gesture = await tester.startGesture(railCenter);
        await tester.pump();

        // Drag partially (about 50% of the range)
        await gesture.moveBy(const Offset(64, 0)); // 64 / 128 range ≈ 50%
        await tester.pump();

        // Scrim should now be visible with partial opacity
        final partialScrimFinder = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0 &&
                color.a < 0.5; // Partial opacity, less than max
          }
          return false;
        });
        expect(partialScrimFinder, findsOneWidget);

        // Clean up
        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'tapping scrim collapses the rail with animation',
      (WidgetTester tester) async {
        bool? lastExtendedValue;

        await tester.pumpWidget(_buildTestApp(
          extended: true,
          onExtendedChanged: (bool value) {
            lastExtendedValue = value;
          },
        ));
        await tester.pumpAndSettle();

        // Find and tap the scrim (it's a full-screen GestureDetector)
        // Tap in the body area (right side of the screen, away from the rail)
        await tester.tapAt(const Offset(600, 300));
        await tester.pump();

        // The callback should have been called with false
        expect(lastExtendedValue, isFalse);

        // The animation should be in progress (not yet settled)
        // Pump partway through the animation
        await tester.pump(const Duration(milliseconds: 50));

        // Scrim should still be visible but fading out
        final fadingScrim = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0;
          }
          return false;
        });
        expect(fadingScrim, findsOneWidget);

        // After settling, the scrim should be gone
        await tester.pumpAndSettle();
        expect(fadingScrim, findsNothing);
      },
    );

    testWidgets(
      'expanded rail renders as overlay, not consuming layout space',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(
          extended: true,
          collapsedWidth: 72,
          expandedWidth: 200,
        ));
        await tester.pumpAndSettle();

        // The DragRail widget in the layout tree should be collapsed width
        final dragRail = find.byType(DragRail);
        final layoutWidth = tester.getSize(dragRail).width;
        expect(layoutWidth, equals(72.0));

        // But the overlay should contain a wider rail
        // Look for the CompositedTransformFollower which contains the expanded rail
        final follower = find.byType(CompositedTransformFollower);
        expect(follower, findsOneWidget);

        final followerSize = tester.getSize(follower);
        expect(followerSize.width, equals(200.0));
      },
    );

    testWidgets(
      'no scrim when rail is collapsed',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(extended: false));
        await tester.pumpAndSettle();

        final scrimFinder = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0;
          }
          return false;
        });
        expect(scrimFinder, findsNothing);
      },
    );

    testWidgets(
      'scrim at full opacity when fully expanded',
      (WidgetTester tester) async {
        await tester.pumpWidget(_buildTestApp(
          extended: true,
        ));
        await tester.pumpAndSettle();

        // Scrim should be at max opacity (0.5 * 1.0 = 0.5)
        final fullScrim = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                (color.a - 0.5).abs() < 0.01;
          }
          return false;
        });
        expect(fullScrim, findsOneWidget);
      },
    );

    testWidgets(
      'overlay rail starts at top-left of parent when padding is present',
      (WidgetTester tester) async {
        const double padding = 16.0;

        await tester.pumpWidget(_buildTestApp(
          extended: true,
          padding: const EdgeInsets.all(padding),
        ));
        await tester.pumpAndSettle();

        // The overlay CompositedTransformFollower should be offset by
        // negative padding so it starts at the top-left of the DragRail parent.
        final follower = find.byType(CompositedTransformFollower);
        expect(follower, findsOneWidget);

        final followerTopLeft = tester.getTopLeft(follower);
        // The DragRail is in a Row inside Scaffold body, so starts at (0,0).
        // With padding=16, the CompositedTransformTarget is at (16,16).
        // The follower should offset by (-16,-16) to align with (0,0).
        expect(followerTopLeft.dx, equals(0.0));
        expect(followerTopLeft.dy, equals(0.0));
      },
    );

    testWidgets(
      'tapping collapsed rail expands it with animation',
      (WidgetTester tester) async {
        bool? lastExtendedValue;

        await tester.pumpWidget(_buildTestApp(
          extended: false,
          onExtendedChanged: (bool value) {
            lastExtendedValue = value;
          },
        ));
        await tester.pumpAndSettle();

        // Tap the collapsed rail
        final dragRail = find.byType(DragRail);
        await tester.tap(dragRail);
        await tester.pump();

        // The callback should have been called with true
        expect(lastExtendedValue, isTrue);

        // Scrim should appear during animation
        final scrimFinder = find.byWidgetPredicate((Widget widget) {
          if (widget is ColoredBox) {
            final color = widget.color;
            return color.r == 0 &&
                color.g == 0 &&
                color.b == 0 &&
                color.a > 0;
          }
          return false;
        });

        // After settling, scrim should be at full opacity
        await tester.pumpAndSettle();
        expect(scrimFinder, findsOneWidget);
      },
    );
  });
}
