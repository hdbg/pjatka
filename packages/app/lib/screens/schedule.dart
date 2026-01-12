import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/schedule/calendar.dart';

final scheduleDestination = Destination(
  label: 'Schedule',
  icon: const Icon(Icons.schedule),
  selectedIcon: const Icon(Icons.schedule_outlined),
  main: AdaptiveBuilders(
    build: (context) => Consumer(
      builder: (context, ref, _) {
        final settings = ref.watch(settingsProvider);
        return Calendar(
          provider: classesProvider(
            WatchFilters(filterGroups: settings.groups.toList()),
          ),
        );
      },
    ),
  ),
  tooltip: 'View your class schedule',
);
