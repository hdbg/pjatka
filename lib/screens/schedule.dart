import 'package:flutter/material.dart';
import 'package:pjatka/features/database/dao/schedule_dao.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/schedule/calendar.dart';

final scheduleDestination = Destination(
  label: 'Schedule',
  icon: const Icon(Icons.schedule),
  selectedIcon: const Icon(Icons.schedule_outlined),
  main: AdaptiveBuilders(
    build: (context) => Calendar(provider: classesProvider(WatchFilters())),
  ),
  tooltip: 'View your class schedule',
);
