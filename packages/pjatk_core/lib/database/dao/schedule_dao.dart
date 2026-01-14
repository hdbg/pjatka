import 'package:drift/drift.dart';
import 'package:talker/talker.dart';
import '../models.dart';
import '../../pjatk_core.dart';

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

class WatchFilters {
  final List<String>? filterGroups;
  final bool excludeIgnored;

  final DateTime? from;
  final DateTime? to;

  const WatchFilters({
    this.filterGroups,
    this.excludeIgnored = true,
    this.from,
    this.to,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatchFilters &&
            (identical(other.filterGroups, filterGroups) ||
                other.filterGroups == filterGroups) &&
            (identical(other.excludeIgnored, excludeIgnored) ||
                other.excludeIgnored == excludeIgnored));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filterGroups, excludeIgnored);
}

class ScheduleDao {
  final ScheduleDatabase db;
  final Talker talker;

  ScheduleDao(this.db, {required this.talker});

  Future<DateTime?> getEarliestUpdateForDate(DateTime date) async {
    final earliest = db.select(db.dayInfo)
      ..limit(1)
      ..where(
        (t) =>
            t.date.year.equals(date.year) &
            t.date.month.equals(date.month) &
            t.date.day.equals(date.day),
      )
      ..orderBy([
        (t) => OrderingTerm(expression: t.lastUpdate, mode: OrderingMode.asc),
      ]);

    final result = await earliest.getSingleOrNull();

    return result?.lastUpdate;
  }

  Stream<List<ScheduledClass>> watchClasses({
    WatchFilters filters = const WatchFilters(),
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

    if (filters.filterGroups != null) {
      query.where(db.group.name.isIn(filters.filterGroups!));
    }

    if (filters.excludeIgnored) {
      query.where(db.subject.ignored.equals(false));
    }

    if (filters.from != null) {
      query.where(
        db.classAppointment.startTime.year.equals(filters.from!.year) &
            db.classAppointment.startTime.month.equals(filters.from!.month) &
            db.classAppointment.startTime.day.equals(filters.from!.day),
      );
    }

    if (filters.to != null) {
      query.where(
        db.classAppointment.endTime.year.equals(filters.to!.year) &
            db.classAppointment.endTime.month.equals(filters.to!.month) &
            db.classAppointment.endTime.day.equals(filters.to!.day),
      );
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
        final teachers = teacherRows
            .map((row) => row.readTable(db.teacher).name)
            .toList();
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
            place: data.appointment.location.isNotEmpty
                ? ClassPlaceOnSite(room: data.appointment.location)
                : ClassPlaceOnline(),
            groups: data.groups.toList(),
          ),
        );
      }

      return classes;
    });
  }

  Future<void> syncClasses(
    DateTime date,
    List<ScheduledClass> parsedClasses,
  ) async {
    talker.debug('Syncing ${parsedClasses.length} meetings for date');

    await db.transaction(() async {
      for (final scheduledClass in parsedClasses) {
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
              // dumb do update to make sqlite return rowid on conflict
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
          ClassPlaceOnline() => '',
          ClassPlaceOnSite(:final room) => room,
        };

        final appointment = await db
            .into(db.classAppointment)
            .insertReturning(
              ClassAppointmentCompanion(
                subjectId: Value(subject.id),
                location: Value(location),
                startTime: Value(scheduledClass.start),
                endTime: Value(scheduledClass.end),
              ),
              onConflict: DoUpdate(
                (old) =>
                    ClassAppointmentCompanion(subjectId: Value(subject.id)),
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
      }

      await db
          .into(db.dayInfo)
          .insertOnConflictUpdate(
            DayInfoCompanion(
              date: Value(DateTime(date.year, date.month, date.day)),
              lastUpdate: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<void> ignoreSubject({
    required String name,
    required String code,
    required ClassKind kind,
  }) async {
    final query = db.update(db.subject)
      ..where(
        (tbl) =>
            tbl.code.equals(code) &
            tbl.name.equals(name) &
            tbl.kind.equalsValue(kind),
      );

    await query.write(SubjectCompanion(ignored: Value(true)));
  }
}
