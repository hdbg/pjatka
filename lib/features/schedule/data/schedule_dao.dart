import 'package:drift/drift.dart';
import '../../parsing/models/class_models.dart';
import '../database.dart';
import 'model_converters.dart';
import '../../../logging.dart';

/// View model for joined query results
class ClassMeetingWithDetails {
  const ClassMeetingWithDetails({
    required this.meeting,
    required this.classData,
    required this.teacher,
    required this.groups,
  });

  final ClassMeetingData meeting;
  final UniversityClassData classData;
  final TeacherData? teacher;
  final List<ClassGroupData> groups;

  /// Convert to freezed Class model for application use
  Class toClass() {
    return ModelConverters.fromDatabaseModels(
      classData,
      meeting,
      teacher,
      groups,
    );
  }
}

/// Database access object for schedule operations
class ScheduleDao {
  const ScheduleDao(this.db);

  final AppDatabase db;

  /// Query all meetings for a given date with full details
  Future<List<ClassMeetingWithDetails>> getMeetingsForDate(
    DateTime date,
  ) async {
    talker.debug('Querying meetings for date: ${date.toIso8601String()}');

    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = db.select(db.classMeetings).join([
      leftOuterJoin(
        db.universityClass,
        db.universityClass.id.equalsExp(db.classMeetings.classId),
      ),
      leftOuterJoin(
        db.teacher,
        db.teacher.id.equalsExp(db.universityClass.teacherId),
      ),
    ])
      ..where(
        db.classMeetings.startTime.isBiggerOrEqualValue(startOfDay) &
            db.classMeetings.startTime.isSmallerThanValue(endOfDay),
      )
      ..orderBy([OrderingTerm.asc(db.classMeetings.startTime)]);

    final results = await query.get();

    // Build details with groups
    final details = <ClassMeetingWithDetails>[];
    for (final row in results) {
      final meeting = row.readTable(db.classMeetings);
      final classData = row.readTable(db.universityClass);
      final teacher = row.readTableOrNull(db.teacher);

      // Fetch groups for this class
      final groups = await (db.select(db.classGroup)
            ..where((g) => g.classId.equals(classData.id)))
          .get();

      details.add(ClassMeetingWithDetails(
        meeting: meeting,
        classData: classData,
        teacher: teacher,
        groups: groups,
      ));
    }

    talker.debug('Found ${details.length} meetings for date');
    return details;
  }

  /// Get the oldest lastChecked timestamp for meetings on a given date
  Future<DateTime?> getOldestLastCheckedForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = db.selectOnly(db.classMeetings)
      ..addColumns([db.classMeetings.lastChecked.min()])
      ..where(
        db.classMeetings.startTime.isBiggerOrEqualValue(startOfDay) &
            db.classMeetings.startTime.isSmallerThanValue(endOfDay),
      );

    final result = await query.getSingleOrNull();
    final oldest = result?.read(db.classMeetings.lastChecked.min());

    if (oldest != null) {
      talker.debug(
        'Oldest lastChecked for date: ${oldest.toIso8601String()}',
      );
    } else {
      talker.debug('No meetings found for date staleness check');
    }

    return oldest;
  }

  /// Upsert teacher (find existing or create new), returns teacher ID
  Future<int> upsertTeacher(String teacherName) async {
    talker.debug('Upserting teacher: $teacherName');

    // Check if exists
    final existing = await (db.select(db.teacher)
          ..where((t) => t.name.equals(teacherName)))
        .getSingleOrNull();

    if (existing != null) {
      talker.debug('Teacher exists with ID: ${existing.id}');
      return existing.id;
    }

    // Insert new
    final id = await db.into(db.teacher).insert(
          TeacherCompanion.insert(name: teacherName),
        );

    talker.debug('Created new teacher with ID: $id');
    return id;
  }

  /// Upsert class definition (insert or update on conflict)
  Future<void> upsertClass(UniversityClassCompanion classData) async {
    talker.debug('Upserting class: ${classData.id.value}');
    await db.into(db.universityClass).insertOnConflictUpdate(classData);
  }

  /// Upsert groups for a class (replace all existing groups)
  Future<void> upsertGroups(String classId, List<String> groupCodes) async {
    talker.debug('Upserting ${groupCodes.length} groups for class: $classId');

    // Delete existing groups for this class
    await (db.delete(db.classGroup)
          ..where((g) => g.classId.equals(classId)))
        .go();

    // Insert new groups
    for (final code in groupCodes) {
      await db.into(db.classGroup).insert(
            ClassGroupCompanion.insert(
              id: code,
              classId: classId,
            ),
          );
    }
  }

  /// Sync meetings for a date (insert new, update existing, delete removed)
  Future<void> _syncMeetings(DateTime date, List<Class> parsedClasses) async {
    talker.debug('Syncing ${parsedClasses.length} meetings for date');

    // Get existing meetings for date
    final existing = await getMeetingsForDate(date);

    // Build map: composite key → meeting ID
    final existingMap = <String, int>{};
    for (final e in existing) {
      final key =
          '${e.meeting.classId}_${e.meeting.startTime.toIso8601String()}_${e.meeting.endTime.toIso8601String()}';
      existingMap[key] = e.meeting.id;
    }

    // Track parsed keys
    final parsedKeys = <String>{};
    final now = DateTime.now();

    // Upsert parsed meetings
    for (final c in parsedClasses) {
      final key =
          '${c.classId}_${c.range.start.toIso8601String()}_${c.range.end.toIso8601String()}';
      parsedKeys.add(key);

      if (existingMap.containsKey(key)) {
        // Update lastChecked
        await (db.update(db.classMeetings)
              ..where((m) => m.id.equals(existingMap[key]!)))
            .write(ClassMeetingsCompanion(
          lastChecked: Value(now),
        ));
        talker.debug('Updated meeting lastChecked: $key');
      } else {
        // Insert new meeting
        await db.into(db.classMeetings).insert(
              ClassMeetingsCompanion.insert(
                classId: c.classId,
                startTime: c.range.start,
                endTime: c.range.end,
                lastChecked: Value(now),
              ),
            );
        talker.debug('Inserted new meeting: $key');
      }
    }

    // Delete meetings that no longer exist
    final keysToDelete = existingMap.keys.where((k) => !parsedKeys.contains(k));
    for (final key in keysToDelete) {
      await (db.delete(db.classMeetings)
            ..where((m) => m.id.equals(existingMap[key]!)))
          .go();
      talker.debug('Deleted removed meeting: $key');
    }

    talker.info('Meeting sync complete for date');
  }

  /// Main sync entry point: sync all classes for a date
  Future<void> syncClassesForDate(
    DateTime date,
    List<Class> parsedClasses,
  ) async {
    talker.info(
      'Starting database sync for ${parsedClasses.length} classes on ${date.toIso8601String()}',
    );

    await db.transaction(() async {
      // Extract unique classes by ID
      final classesByIds = <String, Class>{};
      for (final c in parsedClasses) {
        classesByIds[c.classId] = c;
      }

      // Phase 1: Upsert teachers and collect IDs
      talker.debug('Phase 1: Upserting teachers');
      final teacherIds = <String, int>{};
      for (final c in classesByIds.values) {
        final teacherId = await upsertTeacher(c.lecturer);
        teacherIds[c.lecturer] = teacherId;
      }

      // Phase 2: Upsert class definitions
      talker.debug('Phase 2: Upserting class definitions');
      for (final c in classesByIds.values) {
        final teacherId = teacherIds[c.lecturer];
        await upsertClass(ModelConverters.classToCompanion(c, teacherId));
      }

      // Phase 3: Upsert groups
      talker.debug('Phase 3: Upserting groups');
      for (final c in classesByIds.values) {
        await upsertGroups(
          c.classId,
          ModelConverters.extractGroupCodes(c),
        );
      }

      // Phase 4: Sync meetings
      talker.debug('Phase 4: Syncing meetings');
      await _syncMeetings(date, parsedClasses);
    });

    talker.info('✓ Database sync complete for date');
  }
}
