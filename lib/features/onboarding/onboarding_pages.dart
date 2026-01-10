import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPages {
  static List<PageViewModel> getPages({
    required VoidCallback onManualSetup,
    required VoidCallback onAutomaticSetup,
  }) {
    return [
      // Welcome page
      PageViewModel(
        title: 'Welcome to PJATK App',
        body: 'Your personal schedule assistant for PJATK classes',
        image: Center(
          child: Image.asset('assets/icon.png', height: 175.0),
        ),
        decoration: _getPageDecoration(),
      ),

      // Features page
      PageViewModel(
        title: 'View Your Schedule',
        body: 'Track all your lectures, seminars, and thesis meetings in one place. '
            'Get a clear overview of your week with calendar views.',
        image: Center(
          child: Icon(Icons.calendar_month, size: 150, color: Colors.lightBlue),
        ),
        decoration: _getPageDecoration(),
      ),

      // Setup page - This is the critical page with group setup options
      PageViewModel(
        title: 'Set Up Your Groups',
        bodyWidget: _GroupSetupWidget(
          onManualSetup: onManualSetup,
          onAutomaticSetup: onAutomaticSetup,
        ),
        decoration: _getPageDecoration(),
        footer: const SizedBox.shrink(), // Hide default buttons on this page
      ),
    ];
  }

  static PageDecoration _getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
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

  const _GroupSetupWidget({
    required this.onManualSetup,
    required this.onAutomaticSetup,
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
        const SizedBox(height: 32),

        // Automatic option (recommended)
        _SetupOptionCard(
          icon: Icons.login,
          title: 'Automatic Setup',
          subtitle: 'Login with PJATK credentials to automatically retrieve your groups',
          color: Colors.green,
          recommended: true,
          onTap: onAutomaticSetup,
        ),

        const SizedBox(height: 16),

        // Manual option
        _SetupOptionCard(
          icon: Icons.edit,
          title: 'Manual Setup',
          subtitle: 'Manually enter group names (error-prone, not recommended)',
          color: Colors.orange,
          recommended: false,
          onTap: onManualSetup,
        ),

        const SizedBox(height: 24),
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

  const _SetupOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.recommended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
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
                        if (recommended) ...[
                          const SizedBox(width: 8),
                          Chip(
                            label: const Text('Recommended'),
                            labelStyle: const TextStyle(fontSize: 10),
                            backgroundColor: Colors.green.withValues(alpha: 0.2),
                            side: BorderSide.none,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
