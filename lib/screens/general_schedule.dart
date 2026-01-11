import 'package:flutter/material.dart';
import 'package:pjatka/features/database/dao/schedule_dao.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/schedule/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final generalScheduleDestination = Destination(
  label: 'General Schedule',
  icon: const Icon(Icons.calendar_month),
  selectedIcon: const Icon(Icons.calendar_month_outlined),
  main: AdaptiveBuilders(
    build: (context) => Calendar(
      provider: classesProvider(WatchFilters(filterByUserGroups: false)),
      allowedViews: [CalendarView.day, CalendarView.timelineDay],
    ),
  ),
  tooltip: 'View the general class schedule',
);
