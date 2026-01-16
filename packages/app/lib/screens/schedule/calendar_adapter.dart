import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String _getPlaceDescription(ClassPlace place) {
  return place.when(online: () => 'Online', onSite: (room) => room);
}

Color _getColorForKind(ClassKind kind) {
  return switch (kind) {
    ClassKind.lecture => Colors.blue,
    ClassKind.seminar => Colors.green,
    ClassKind.diplomaThesis => Colors.purple,
  };
}

class AppointmentAdapter extends Appointment {
  final ScheduledClass scheduledClass;

  AppointmentAdapter(this.scheduledClass)
    : super(
        startTime: scheduledClass.start.toLocal(),
        endTime: scheduledClass.end.toLocal(),
        subject:
            '${scheduledClass.code} - ${_getPlaceDescription(scheduledClass.place)}',
        location: _getPlaceDescription(scheduledClass.place),
        color: _getColorForKind(scheduledClass.kind),
      );

  String get place => _getPlaceDescription(scheduledClass.place);
}

class ScheduleDataSource extends CalendarDataSource {
  final ProviderContainer container;
  final WatchFilters baseFilters;

  ProviderSubscription<AsyncValue<List<ScheduledClass>>>? _subscription;
  WatchFilters _currentFilters;

  ScheduleDataSource({
    required this.container,
    required this.baseFilters,
  }) : _currentFilters = baseFilters {
    appointments = [];
    _subscribe();
  }

  void _subscribe() {
    _subscription?.close();
    _subscription = container.listen(
      classesProvider(_currentFilters),
      (previous, next) {
        final newClasses = next.value;
        if (newClasses == null) return;

        final newAppointments =
            newClasses.map((c) => AppointmentAdapter(c)).toList();

        talker.debug(
          'Loaded ${newAppointments.length} appointments for ${_currentFilters.from?.toIso8601String()} - ${_currentFilters.to?.toIso8601String()}',
        );
        appointments = newAppointments;
        notifyListeners(CalendarDataSourceAction.reset, appointments!);
      },
      fireImmediately: true,
    );
  }

  void updateVisibleDates(List<DateTime> visibleDates) {
    if (visibleDates.isEmpty) return;

    final from = visibleDates.reduce((a, b) => a.isBefore(b) ? a : b);
    final to = visibleDates.reduce((a, b) => a.isAfter(b) ? a : b);
    final toEndOfDay = DateTime(to.year, to.month, to.day, 23, 59, 59);

    final newFilters = baseFilters.copyWith(from: from, to: toEndOfDay);
    if (newFilters == _currentFilters) return;

    _currentFilters = newFilters;
    _subscribe();
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}
