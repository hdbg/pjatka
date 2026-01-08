import 'package:flutter/material.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<ScheduledClass> classes) {
    appointments = classes.map(_classToAppointment).toList();
  }

  Appointment _classToAppointment(ScheduledClass classItem) {
    final startTime = classItem.start.toLocal();
    final endTime = classItem.end.toLocal();

    final color = _getColorForKind(classItem.kind);

    final location = classItem.place.when(
      online: () => 'Online',
      onSite: (room) => room,
    );

    final subject = '${classItem.name} (${classItem.code})';

    return Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      notes: 'Lecturer: ${classItem.lecturer}',
      location: location,
      color: color,
      id: classItem.classId,
    );
  }

  Color _getColorForKind(ClassKind kind) {
    return switch (kind) {
      ClassKind.lecture => Colors.blue,
      ClassKind.seminar => Colors.green,
      ClassKind.diplomaThesis => Colors.purple,
    };
  }
}
