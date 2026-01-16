import 'package:flutter/material.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/schedule/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final generalScheduleDestination = Destination(
  label: 'General Schedule',
  icon: const Icon(Icons.calendar_month),
  selectedIcon: const Icon(Icons.calendar_month_outlined),
  main: AdaptiveBuilders(
    build: (context) => Calendar(
      filters: const WatchFilters(excludeIgnored: false),
      allowedViews: [CalendarView.day, CalendarView.timelineDay],
    ),
  ),
  tooltip: 'View the general class schedule',
);
