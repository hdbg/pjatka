import 'package:flutter/material.dart';
import 'package:pjatka/home.dart';

final settingsDestination = Destination(
  label: 'Settings',
  icon: const Icon(Icons.settings),
  selectedIcon: const Icon(Icons.settings_outlined),
  main: () => SettingsDispatcher(),
  tooltip: 'App Settings',
);

class SettingsDispatcher extends AdaptiveDispatcher {
  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      'Settings Screen',
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}
