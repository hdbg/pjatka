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

  static Stream<List<ScheduledClass>> watchClasses(SettingsState settings) {
    final query = database.select(database.universityClass).join([
      leftOuterJoin(
        database.teacher,
        database.teacher.classId.equalsExp(database.universityClass.id),
      ),
      leftOuterJoin(
        database.group,
        database.group.classId.equalsExp(database.universityClass.id),
      ),
    ])..where(database.group.name.isIn(settings.groups));

    final rows = query.watch();

    return rows.map((rows) {
      return rows.map((row) {
        final universityClass = row.readTable(database.universityClass);
        final teacher = row.readTableOrNull(database.teacher);
        final group = row.readTableOrNull(database.group);

        return ScheduledClass(
          classId: universityClass.id,
          name: universityClass.name,
          code: universityClass.code,
          kind: universityClass.kind,
          lecturer: teacher?.name ?? 'Unknown',
          start: universityClass.startTime,
          end: universityClass.endTime,
          place: universityClass.room != null
              ? ClassPlaceOnSite(room: universityClass.room!)
              : ClassPlaceOnline(),
          groups: group != null ? [group.name] : [],
        );
      }).toList();
    });
  }

  static Future<void> syncClasses(
    DateTime date,
    List<ScheduledClass> parsedClasses,
  ) async {
    talker.debug('Syncing ${parsedClasses.length} meetings for date');

    final oldCount = await database.managers.universityClass
        .filter(
          (f) =>
              f.startTime.column.year.equals(date.year) &
              f.startTime.column.month.equals(date.month) &
              f.startTime.column.day.equals(date.day),
        )
        .delete();

    talker.debug('Deleted $oldCount old meetings from database');

    // await db.transaction(() async {
    for (final scheduledClass in parsedClasses) {
      await database
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
        batch.insertAll(database.teacher, [
          TeacherCompanion(
            name: Value(scheduledClass.lecturer),
            classId: Value(scheduledClass.classId),
          ),
        ]);

        batch.insertAll(
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
    return;
    // });
  }
}
