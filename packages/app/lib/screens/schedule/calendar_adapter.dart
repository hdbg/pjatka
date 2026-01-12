import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/models.dart';
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

// Exploit the fact that it can be casted to Appointment later, so calendar is compatible
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
  final StreamProvider<List<ScheduledClass>> provider;

  late final ProviderSubscription<Future<List<ScheduledClass>>> subscription;

  ScheduleDataSource({required this.container, required this.provider}) {
    appointments = [];

    subscription = container.listen(
      provider.future,
      (previous, next) {
        next.then((newClasses) {
          if (newClasses.isEmpty) {
            return;
          }
          final newAppointments = <Appointment>[];

          for (final classItem in newClasses) {
            newAppointments.add(AppointmentAdapter(classItem));
          }

          talker.debug(
            'Loaded ${newAppointments.length} appointments for schedule',
          );
          appointments = newAppointments;
          notifyListeners(CalendarDataSourceAction.reset, appointments!);
        });
      },
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.close();
  }
}