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
      return const Center(
        child: Text('Please select a setting from the list.'),
      );
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
