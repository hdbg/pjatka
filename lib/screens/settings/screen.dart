import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/settings/settings/debug.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';
import 'package:pjatka/utils.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen.g.dart';

final List<Setting> allSettings = [groupSetting, debugSetting];

class Setting {
  final String title;
  final IconData icon;
  final String description;
  final WidgetBuilder builder;

  const Setting({
    required this.title,
    required this.icon,
    required this.description,
    required this.builder,
  });
}

@riverpod
class Selected extends _$Selected {
  @override
  Setting? build() {
    return null;
  }

  void select(Setting selection) {
    talker.debug('Selected setting: ${selection.title}');
    state = selection;
  }

  void clear() {
    talker.debug('Cleared selected setting');
    state = null;
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsList(
      darkTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).colorScheme.surface,
      ),
      sections: [
        SettingsSection(
          title: const Text('Settings'),
          tiles: allSettings
              .map(
                (setting) => SettingsTile(
                  leading: Icon(setting.icon),
                  title: Text(setting.title),
                  description: Text(setting.description),
                  onPressed: (context) {
                    ref.read(selectedProvider.notifier).select(setting);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

final _navigatorKey = GlobalKey<NavigatorState>();

class SettingsScreenSmall extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Setting?>(selectedProvider, (previous, next) {
      talker.debug('Settings selection changed: $next');
      if (next == null) {
        talker.debug('No setting selected, doing nothing');
        return;
      }

      talker.debug('Navigating to setting: ${next.title}');
      _navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _navigatorKey.currentState?.pop();
                },
              ),
              title: Text(next.title),
            ),
            body: next.builder(context),
          ),
        ),
      );

      // Reset selection so the listener can trigger again for the same setting
      ref.read(selectedProvider.notifier).clear();
    });

    return Navigator(
      key: _navigatorKey,
      onGenerateInitialRoutes: (navigator, initialRoute) {
        return [MaterialPageRoute(builder: (context) => _SettingsList())];
      },
    );
  }
}

class SettingsPane extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSetting = ref.watch(selectedProvider);

    if (selectedSetting == null) {
      return _EmptySettingsState();
    }

    return AnimatedSwitcher(
      duration: transitionDuration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: selectedSetting.builder(context),
    );
  }
}

class _EmptySettingsState extends StatelessWidget {
  const _EmptySettingsState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_suggest,
                size: 64,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Setting Selected',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Select a setting from the list to view its options',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Available settings will appear here when you select them from the sidebar.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final settingsDestination = Destination(
  label: 'Settings',
  icon: const Icon(Icons.settings),
  selectedIcon: const Icon(Icons.settings_outlined),
  main: Adaptive(
    buildSmall: (context) => SettingsScreenSmall(),
    build: (context) => SettingsScreenSmall(),
    buildMediumLarge: (context) => const _SettingsList(),
    buildLarge: (context) => const _SettingsList(),
    buildExtraLarge: (context) => const _SettingsList(),
  ),
  secondary: Adaptive(
    buildMediumLarge: (context) => SettingsPane(),
    buildLarge: (context) => SettingsPane(),
    buildExtraLarge: (context) => SettingsPane(),
  ),
  tooltip: 'App Settings',
);
