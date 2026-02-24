import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pjatka/screens/groups_retriever/group_setup_widget.dart';
import 'package:sizer/sizer.dart';

class OnboardingPages {
  static List<PageViewModel> getPages({
    required VoidCallback onManualSetup,
    required VoidCallback onAutomaticSetup,
    required VoidCallback onIcalSetup,
  }) {
    final pages = [
      PageViewModel(
        title: 'Welcome to PJATKa App (unofficial)',
        body: 'Your personal schedule assistant for PJATK classes',
        image: Center(child: Image.asset('./assets/icon.png', height: 40.h, )),
        decoration: _getPageDecoration(),
      ),
    ];

    pages.addAll([
      PageViewModel(
        title: 'View Your Schedule',
        body:
            'Track all your lectures, seminars, and thesis meetings in one place. '
            'Get a clear overview of your week with calendar views.',
        image: Center(
          child: Icon(
            Icons.calendar_month,
            size: 15.h,
            color: Colors.lightBlue,
          ),
        ),
        decoration: _getPageDecoration(),
      ),

      PageViewModel(
        title: 'Set Up Your Groups',
        bodyWidget: GroupSetupWidget(
          onManualSetup: onManualSetup,
          onAutomaticSetup: onAutomaticSetup,
          onIcalSetup: onIcalSetup,
          showSettingsHint: true,
        ),
        decoration: _getPageDecoration(),
      ),
    ]);

    return pages;
  }

  static PageDecoration _getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );
  }
}
