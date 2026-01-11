import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pjatka/features/schedule/models.dart';

part 'database.g.dart';

class Subject extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get code => text().withLength(min: 2, max: 32)();
  TextColumn get kind => textEnum<ClassKind>()();

  BoolColumn get ignored => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, code, kind},
  ];
}

@TableIndex(name: 'appointment_start', columns: {#startTime})
class ClassAppointment extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId => integer().references(
    Subject,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  // Empty location is treated as "online"
  TextColumn get location => text().withLength(min: 0, max: 256)();

  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();

  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {subjectId, startTime, endTime, location},
  ];

  @override
  bool get isStrict => true;
}

class Teacher extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 512)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name},
  ];

  @override
  bool get isStrict => true;
}

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();

  List<Set<Column>> get uniqueKeys => [
    {name},
  ];

  @override
  bool get isStrict => true;
}

class ClassGroup extends Table {
  IntColumn get groupId => integer().references(
    Group,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  IntColumn get appointmentId => integer().references(
    ClassAppointment,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  @override
  Set<Column> get primaryKey => {groupId, appointmentId};

  @override
  bool get isStrict => true;
}

class ClassTeacher extends Table {
  IntColumn get teacherId => integer().references(
    Teacher,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  IntColumn get appointmentId => integer().references(
    ClassAppointment,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();

  @override
  Set<Column> get primaryKey => {teacherId, appointmentId};

  @override
  bool get isStrict => true;
}

@DriftDatabase(
  tables: [Teacher, Group, ClassGroup, ClassTeacher, ClassAppointment, Subject],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'pjatkapp',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}

@override
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {},
    beforeOpen: (details) async {
      await db.customStatement('PRAGMA journal_mode=WAL');
      await db.customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

final db = AppDatabase();
