import 'package:drift/drift.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/utils.dart';

class _AppointmentData {
  final SubjectData subject;
  final ClassAppointmentData appointment;
  final Set<String> groups;

  _AppointmentData({
    required this.subject,
    required this.appointment,
    required this.groups,
  });
}

class ScheduleDao {
  static Future<DateTime?> getEarliestUpdateForDate(DateTime date) async {
    final earliest = await db.select(db.classAppointment)
      ..limit(1)
      ..where(
        (t) =>
            t.startTime.year.equals(date.year) &
            t.startTime.month.equals(date.month) &
            t.startTime.day.equals(date.day),
      )
      ..orderBy([
        (t) => OrderingTerm(expression: t.lastUpdated, mode: OrderingMode.asc),
      ]);

    final result = await earliest.getSingleOrNull();

    return result?.lastUpdated;
  }

  static Stream<List<ScheduledClass>> watchClasses(
    SettingsState settings, {
    bool filterByGroups = true,
  }) {
    // Main query - join only subject and appointment, plus groups for filtering
    final query = db.select(db.subject).join([
      innerJoin(
        db.classAppointment,
        db.classAppointment.subjectId.equalsExp(db.subject.id),
      ),
      innerJoin(
        db.classGroup,
        db.classGroup.appointmentId.equalsExp(db.classAppointment.id),
      ),
      innerJoin(db.group, db.classGroup.groupId.equalsExp(db.group.id)),
    ]);

    if (filterByGroups) {
      query.where(db.group.name.isIn(settings.groups));
    }

    final rows = query.watch();

    return rows.asyncMap((rows) async {
      // Group rows by appointment ID to avoid duplicates
      final appointmentMap = <int, _AppointmentData>{};
      
      for (final row in rows) {
        final subject = row.readTable(db.subject);
        final appointment = row.readTable(db.classAppointment);
        final group = row.readTable(db.group);

        if (!appointmentMap.containsKey(appointment.id)) {
          appointmentMap[appointment.id] = _AppointmentData(
            subject: subject,
            appointment: appointment,
            groups: {},
          );
        }
        
        appointmentMap[appointment.id]!.groups.add(group.name);
      }

      final classes = <ScheduledClass>[];
      for (final data in appointmentMap.values) {
        final teachersQuery = db.select(db.teacher).join([
          innerJoin(
            db.classTeacher,
            db.classTeacher.teacherId.equalsExp(db.teacher.id),
          ),
        ])..where(db.classTeacher.appointmentId.equals(data.appointment.id));

        final teacherRows = await teachersQuery.get();
        final teachers = teacherRows.map((row) => row.readTable(db.teacher).name).toList();
        final teacherStr = teachers.isNotEmpty ? teachers.first : '';

        classes.add(
          ScheduledClass(
            classId: data.subject.id.toString(),
            name: data.subject.name,
            code: data.subject.code,
            kind: data.subject.kind,
            lecturer: teacherStr,
            start: data.appointment.startTime,
            end: data.appointment.endTime,
            place: data.appointment.location != null
                ? ClassPlaceOnSite(room: data.appointment.location!)
                : ClassPlaceOnline(),
            groups: data.groups.toList(),
          ),
        );
      }

      return classes;
    });
  }

  static Future<void> syncClasses(
    DateTime date,
    List<ScheduledClass> parsedClasses,
  ) async {
    talker.debug('Syncing ${parsedClasses.length} meetings for date');

    for (final scheduledClass in parsedClasses) {
      await db.transaction(() async {
        await db.batch((batch) async {
          batch.insertAll(
            db.teacher,
            [scheduledClass.lecturer].map(
              (lecturerName) => TeacherCompanion(name: Value(lecturerName)),
            ),
            onConflict: DoNothing(target: [db.teacher.name]),
          );

          batch.insertAll(
            db.group,
            scheduledClass.groups.map(
              (groupName) => GroupCompanion(name: Value(groupName)),
            ),
            onConflict: DoNothing(target: [db.group.name]),
          );
        });

        final subject = await db
            .into(db.subject)
            .insertReturning(
              SubjectCompanion(
                name: Value(scheduledClass.name),
                code: Value(scheduledClass.code),
                kind: Value(scheduledClass.kind),
              ),
              onConflict: DoUpdate(
                (old) => SubjectCompanion(
                  name: Value(scheduledClass.name),
                  code: Value(scheduledClass.code),
                  kind: Value(scheduledClass.kind),
                ),
                target: [db.subject.name, db.subject.code, db.subject.kind],
              ),
            );

        final location = switch (scheduledClass.place) {
          ClassPlaceOnline() => null,
          ClassPlaceOnSite(:final room) => room,
        };

        final appointment = await db
            .into(db.classAppointment)
            .insertReturning(
              ClassAppointmentCompanion(
                subjectId: Value(subject.id),
                location: Value.absentIfNull(location),
                startTime: Value(scheduledClass.start),
                endTime: Value(scheduledClass.end),
              ),
              onConflict: DoUpdate(
                (old) => ClassAppointmentCompanion(
                  subjectId: Value(subject.id),
                  location: Value.absentIfNull(location),
                  startTime: Value(scheduledClass.start),
                  endTime: Value(scheduledClass.end),
                  lastUpdated: Value(DateTime.now()),
                ),
                target: [
                  db.classAppointment.subjectId,
                  db.classAppointment.startTime,
                  db.classAppointment.endTime,
                  db.classAppointment.location,
                ],
              ),
            );

        final appointmentId = Variable<int>(appointment.id);
        await db
            .into(db.classGroup)
            .insertFromSelect(
              db.selectOnly(db.group, distinct: true)
                ..addColumns([db.group.id, appointmentId])
                ..where(db.group.name.isIn(scheduledClass.groups)),
              columns: {
                db.classGroup.groupId: db.group.id,
                db.classGroup.appointmentId: appointmentId,
              },
              onConflict: DoNothing(),
            );
        await db
            .into(db.classTeacher)
            .insertFromSelect(
              db.selectOnly(db.teacher, distinct: true)
                ..addColumns([db.teacher.id, appointmentId])
                ..where(db.teacher.name.isIn([scheduledClass.lecturer])),
              columns: {
                db.classTeacher.teacherId: db.teacher.id,
                db.classTeacher.appointmentId: appointmentId,
              },
              onConflict: DoNothing(),
            );
      });
    }
  }
}
