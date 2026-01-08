import 'package:drift/drift.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/utils.dart';

class ScheduleDao {
  const ScheduleDao(this.db);

  final AppDatabase db;

  Future<DateTime?> getEarliestUpdateForDate(DateTime date) async {
    final earliest = await db.select(db.universityClass)
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

  Future<List<ScheduledClass>> getMeetingsForDate(DateTime date) async {
    talker.debug('Querying meetings for date: ${date.toIso8601String()}');

    final query =
        db.select(db.universityClass).join([
          leftOuterJoin(
            db.teacher,
            db.teacher.classId.equalsExp(db.universityClass.id),
          ),
          leftOuterJoin(
            db.group,
            db.group.classId.equalsExp(db.universityClass.id),
          ),
        ])..where(
          db.universityClass.startTime.year.equals(date.year) &
              db.universityClass.startTime.month.equals(date.month) &
              db.universityClass.startTime.day.equals(date.day),
        );

    final rows = await query.get();

    talker.debug('Found ${rows.length} meetings for date');

    return rows.map((row) {
      final universityClass = row.readTable(db.universityClass);
      final teacher = row.readTableOrNull(db.teacher);
      final group = row.readTableOrNull(db.group);

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
  }

  Future<void> syncClasses(
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
      await db
          .into(db.universityClass)
          .insert(
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

      await db.batch((batch) {
        // add here a `.map` if we upgrade parser to handle multiple lecturers
        batch.insertAll(db.teacher, [
          TeacherCompanion(
            name: Value(scheduledClass.lecturer),
            classId: Value(scheduledClass.classId),
          ),
        ]);

        batch.insertAll(
          db.group,
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
