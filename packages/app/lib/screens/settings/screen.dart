import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/settings/settings/debug.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';
import 'package:pjatka/screens/settings/settings/groups_retrieval.dart';
import 'package:pjatka/screens/settings/settings/parser_range.dart';
import 'package:pjatka/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen.g.dart';

final List<Setting> allSettings = [
  groupSetting,
  groupsRetrievalSetting,
  parserRangeSetting,
  debugSetting,
];

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

/// A single custom settings tile.
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.setting,
    required this.onTap,
  });

  final Setting setting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(setting.icon, size: 24, color: colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    setting.title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    setting.description,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

/// The list of settings to choose from.
class _SettingsList extends ConsumerWidget {
  const _SettingsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              for (int i = 0; i < allSettings.length; i++) ...[
                _SettingsTile(
                  setting: allSettings[i],
                  onTap: () =>
                      ref.read(selectedProvider.notifier).select(allSettings[i]),
                ),
                if (i < allSettings.length - 1)
                  Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: colorScheme.outline.withValues(alpha: 0.15),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

final _navigatorKey = GlobalKey<NavigatorState>();

/// The settings screen for small devices, using a Navigator to open setting content on top of current page
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

/// The pane that displays the selected setting's content.
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
  main: AdaptiveBuilders(
    buildSmall: (context) => SettingsScreenSmall(),
    build: (context) => const _SettingsList(),
    buildMediumLarge: (context) => const _SettingsList(),
    buildLarge: (context) => const _SettingsList(),
    buildExtraLarge: (context) => const _SettingsList(),
  ),
  secondary: AdaptiveBuilders(
    build: (context) => SettingsPane(),
    buildMediumLarge: (context) => SettingsPane(),
    buildLarge: (context) => SettingsPane(),
    buildExtraLarge: (context) => SettingsPane(),
  ),
  tooltip: 'App Settings',
);
