import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
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

    if (kIsWeb) {
      pages.add(
        PageViewModel(
          title: 'Note on Web Version',
          body:
              'Web version is proxied through developer owned proxy because of CORS restrictions.\n '
              'As such, automatic group retrieval is disabled, because it requires login with your PJATK credentials. ',
          image: Center(
            child: Icon(Icons.warning, size: 15.h, color: Colors.yellow),
          ),
          decoration: _getPageDecoration(),
        ),
      );
    }

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
        bodyWidget: _GroupSetupWidget(
          onManualSetup: onManualSetup,
          onAutomaticSetup: onAutomaticSetup,
          onIcalSetup: onIcalSetup,
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

class _GroupSetupWidget extends StatelessWidget {
  final VoidCallback onManualSetup;
  final VoidCallback onAutomaticSetup;
  final VoidCallback onIcalSetup;

  const _GroupSetupWidget({
    required this.onManualSetup,
    required this.onAutomaticSetup,
    required this.onIcalSetup,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Choose how to add your study groups to get started',
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 3.h),

        // iCal option (recommended)
        _SetupOptionCard(
          icon: Icons.upload_file,
          title: 'Import from iCal',
          subtitle:
              'Upload an iCal schedule file to detect your study groups',
          color: Colors.blue,
          recommended: true,
          onTap: onIcalSetup,
        ),

        SizedBox(height: 1.5.h),

        // Automatic option
        _SetupOptionCard(
          icon: Icons.login,
          title: 'Automatic Setup',
          subtitle:
              'Login with PJATK credentials to automatically retrieve your groups',
          color: Colors.green,
          recommended: false,
          onTap: onAutomaticSetup,
          disabled: kIsWeb,
        ),

        

        SizedBox(height: 1.5.h),

        // Manual option
        _SetupOptionCard(
          icon: Icons.edit,
          title: 'Manual Setup',
          subtitle: 'Manually enter group names (error-prone, not recommended)',
          color: Colors.orange,
          recommended: false,
          onTap: onManualSetup,
        ),



        SizedBox(height: 2.h),
        Text(
          'You can change this later in Settings',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _SetupOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool recommended;
  final VoidCallback onTap;
  final bool disabled;

  const _SetupOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.recommended,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = disabled ? Colors.grey : color;

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Card(
        elevation: disabled ? 0 : 2,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(1.h),
                  decoration: BoxDecoration(
                    color: effectiveColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 3.h, color: effectiveColor),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (recommended && !disabled) ...[
                            SizedBox(width: 2.w),
                            Chip(
                              label: const Text('Recommended'),
                              labelStyle: const TextStyle(fontSize: 10),
                              backgroundColor: Colors.green.withValues(
                                alpha: 0.2,
                              ),
                              side: BorderSide.none,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 1.5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
