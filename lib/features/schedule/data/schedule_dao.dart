import 'package:drift/drift.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/utils.dart';

class ScheduleDao {
  static Future<DateTime?> getEarliestUpdateForDate(DateTime date) async {
    final earliest = await database.select(database.universityClass)
      ..limit(1)
      ..where(
        (t) =>
            t.startTime.year.equals(date.year) &
            t.startTime.month.equals(date.month) &
            t.startTime.day.equals(date.day),
      )
      ..orderBy([
        (t) => OrderingTerm(expression: t.lastChecked, mode: OrderingMode.asc),
      ]);

    final result = await earliest.getSingleOrNull();

    return result?.startTime;
  }

  static Stream<List<ScheduledClass>> watchClasses(
    SettingsState settings, {
    bool filterByGroups = true,
  }) {
    final query = database.select(database.universityClass).join([
      leftOuterJoin(
        database.teacher,
        database.teacher.classId.equalsExp(database.universityClass.id),
      ),
      leftOuterJoin(
        database.group,
        database.group.classId.equalsExp(database.universityClass.id),
      ),
    ]);

    if (filterByGroups) {
      query.where(database.group.name.isIn(settings.groups));
    }

    final rows = query.watch();

    return rows.map((rows) {
      talker.debug('Mapping ${rows.length} database rows to ScheduledClass');
      final classMap =
          <String, (UniversityClassData, Set<String>, Set<String>)>{};

      for (final row in rows) {
        final universityClass = row.readTable(database.universityClass);
        final teacher = row.readTableOrNull(database.teacher);
        final group = row.readTableOrNull(database.group);

        if (!classMap.containsKey(universityClass.id)) {
          classMap[universityClass.id] = (universityClass, {}, {});
        }

        if (teacher != null) {
          classMap[universityClass.id]!.$2.add(teacher.name);
        }
        if (group != null) {
          classMap[universityClass.id]!.$3.add(group.name);
        }
      }

      return classMap.values.map((entry) {
        final universityClass = entry.$1;
        final teachers = entry.$2;
        final groups = entry.$3;

        return ScheduledClass(
          classId: universityClass.id,
          name: universityClass.name,
          code: universityClass.code,
          kind: universityClass.kind,
          lecturer: teachers.isNotEmpty ? teachers.first : 'Unknown',
          start: universityClass.startTime,
          end: universityClass.endTime,
          place: universityClass.room != null
              ? ClassPlaceOnSite(room: universityClass.room!)
              : ClassPlaceOnline(),
          groups: groups.toList(),
        );
      }).toList();
    });
  }

  static Future<void> syncClasses(
    DateTime date,
    List<ScheduledClass> parsedClasses,
  ) async {
    talker.debug('Syncing ${parsedClasses.length} meetings for date');

    var totalInserted = 0;
    for (final scheduledClass in parsedClasses) {
      totalInserted += await database
          .into(database.universityClass)
          .insertOnConflictUpdate(
            UniversityClassCompanion(
              id: Value(scheduledClass.classId),
              name: Value(scheduledClass.name),
              code: Value(scheduledClass.code),
              kind: Value(scheduledClass.kind),
              startTime: Value(scheduledClass.start),
              endTime: Value(scheduledClass.end),
              room: scheduledClass.place is ClassPlaceOnSite
                  ? Value((scheduledClass.place as ClassPlaceOnSite).room)
                  : const Value.absent(),
            ),
          );

      await database.batch((batch) {
        // add here a `.map` if we upgrade parser to handle multiple lecturers
        batch.insertAllOnConflictUpdate(database.teacher, [
          TeacherCompanion(
            name: Value(scheduledClass.lecturer),
            classId: Value(scheduledClass.classId),
          ),
        ]);

        batch.insertAllOnConflictUpdate(
          database.group,
          scheduledClass.groups
              .map(
                (groupName) => GroupCompanion(
                  name: Value(groupName),
                  classId: Value(scheduledClass.classId),
                ),
              )
              .toList(),
        );
      });
    }
    talker.info(
      'Synced classes for ${date.toIso8601String()}: $totalInserted inserted/updated',
    );
  }
}
