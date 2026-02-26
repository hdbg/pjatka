import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/features/onboarding/onboarding_pages.dart';
import 'package:sizer/sizer.dart';

void main() {
  group('OnboardingPages', () {
    testWidgets('getPages returns at least 3 pages on non-web',
        (tester) async {
      // OnboardingPages uses Sizer extensions (e.g. 40.h) so it needs a
      // Sizer ancestor that has completed its initial build.
      late List pages;

      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            pages = OnboardingPages.getPages(
              onManualSetup: () {},
              onAutomaticSetup: () {},
              onIcalSetup: () {},
            );
            return MaterialApp(home: Scaffold());
          },
        ),
      );

      // Welcome page + View Your Schedule + Set Up Your Groups (+ optional web note)
      expect(pages.length, greaterThanOrEqualTo(3));
    });

    testWidgets('first page is the welcome page', (tester) async {
      late List pages;

      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            pages = OnboardingPages.getPages(
              onManualSetup: () {},
              onAutomaticSetup: () {},
              onIcalSetup: () {},
            );
            return MaterialApp(home: Scaffold());
          },
        ),
      );

      expect(pages.first.title, 'Welcome to PJATKa App (unofficial)');
      expect(
        pages.first.body,
        'Your personal schedule assistant for PJATK classes',
      );
    });

    testWidgets('last page is the group setup page', (tester) async {
      late List pages;

      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            pages = OnboardingPages.getPages(
              onManualSetup: () {},
              onAutomaticSetup: () {},
              onIcalSetup: () {},
            );
            return MaterialApp(home: Scaffold());
          },
        ),
      );

      expect(pages.last.title, 'Set Up Your Groups');
    });

    testWidgets('setup page contains all setup options', (tester) async {
      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            final pages = OnboardingPages.getPages(
              onManualSetup: () {},
              onAutomaticSetup: () {},
              onIcalSetup: () {},
            );
            // Render the last page's bodyWidget
            return MaterialApp(
              theme: ThemeData.dark(),
              home: Scaffold(body: pages.last.bodyWidget),
            );
          },
        ),
      );

      expect(find.text('Import from iCal'), findsOneWidget);
      expect(find.text('Automatic Setup'), findsOneWidget);
      expect(find.text('Manual Setup'), findsOneWidget);
      expect(find.text('Recommended'), findsOneWidget);
      expect(
        find.text('You can change this later in Settings'),
        findsOneWidget,
      );
    });

    testWidgets('manual setup callback is invoked on tap', (tester) async {
      var manualCalled = false;

      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            final pages = OnboardingPages.getPages(
              onManualSetup: () => manualCalled = true,
              onAutomaticSetup: () {},
              onIcalSetup: () {},
            );
            return MaterialApp(
              theme: ThemeData.dark(),
              home: Scaffold(body: pages.last.bodyWidget),
            );
          },
        ),
      );

      await tester.tap(find.text('Manual Setup'));
      expect(manualCalled, true);
    });

    testWidgets('iCal setup callback is invoked on tap', (tester) async {
      var icalCalled = false;

      await tester.pumpWidget(
        Sizer(
          builder: (context, orientation, deviceType) {
            final pages = OnboardingPages.getPages(
              onManualSetup: () {},
              onAutomaticSetup: () {},
              onIcalSetup: () => icalCalled = true,
            );
            return MaterialApp(
              theme: ThemeData.dark(),
              home: Scaffold(body: pages.last.bodyWidget),
            );
          },
        ),
      );

      await tester.tap(find.text('Import from iCal'));
      expect(icalCalled, true);
    });
  });
}
