import 'package:drift/drift.dart';
import '../../parsing/models/class_models.dart';
import '../database.dart';

/// Bidirectional conversion between freezed models and Drift models
class ModelConverters {
  /// Convert freezed Class to UniversityClassCompanion for database insert/update
  static UniversityClassCompanion classToCompanion(Class c, int? teacherId) {
    // Extract room from ClassPlace
    final String? room = c.place.when(
      online: () => null,
      onSite: (room) => room,
    );

    return UniversityClassCompanion.insert(
      id: c.classId,
      name: c.name,
      code: c.code,
      kind: c.kind,
      room: Value(room),
      teacherId: Value(teacherId),
    );
  }

  /// Convert freezed Class to ClassMeetingsCompanion for database insert/update
  static ClassMeetingsCompanion classToMeetingCompanion(Class c) {
    return ClassMeetingsCompanion.insert(
      classId: c.classId,
      startTime: c.range.start,
      endTime: c.range.end,
      lastChecked: Value(DateTime.now()),
    );
  }

  /// Extract group codes from freezed Class
  static List<String> extractGroupCodes(Class c) {
    return c.groups.map((g) => g.code).toList();
  }

  /// Convert Drift database models back to freezed Class model
  static Class fromDatabaseModels(
    UniversityClassData classData,
    ClassMeetingData meeting,
    TeacherData? teacher,
    List<ClassGroupData> groups,
  ) {
    // Reconstruct ClassPlace from room
    final ClassPlace place = classData.room == null
        ? const ClassPlace.online()
        : ClassPlace.onSite(room: classData.room!);

    // Reconstruct TimeRange from meeting times
    final TimeRange range = TimeRange(
      start: meeting.startTime,
      end: meeting.endTime,
    );

    // Reconstruct Group list
    final List<Group> groupList = groups
        .map((g) => Group(code: g.id))
        .toList();

    return Class(
      classId: classData.id,
      name: classData.name,
      code: classData.code,
      kind: classData.kind,
      lecturer: teacher?.name ?? 'Unknown',
      range: range,
      place: place,
      groups: groupList,
    );
  }
}
