import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../parsing/models/class_models.dart';

/// Custom calendar data source that converts Class objects to Appointments
class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Class> classes) {
    appointments = classes.map(_classToAppointment).toList();
  }

  /// Convert a Class object to a calendar Appointment
  Appointment _classToAppointment(Class classItem) {
    // Convert UTC times to local for display
    final startTime = classItem.range.start.toLocal();
    final endTime = classItem.range.end.toLocal();

    // Color based on ClassKind
    final color = _getColorForKind(classItem.kind);

    // Location string - use freezed .when() for exhaustive matching
    final location = classItem.place.when(
      online: () => 'Online',
      onSite: (room) => room,
    );

    // Subject includes name and code for clarity
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

  /// Get color based on class type
  Color _getColorForKind(ClassKind kind) {
    return switch (kind) {
      ClassKind.lecture => Colors.blue,
      ClassKind.seminar => Colors.green,
      ClassKind.diplomaThesis => Colors.purple,
    };
  }
}
