import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pjatka/features/schedule/models.dart';

part 'database.g.dart';

class PersistedObject extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().withLength(min: 1, max: 64)();
  TextColumn get value => text()();
}

@TableIndex(name: 'class_start', columns: {#startTime})
class UniversityClass extends Table {
  TextColumn get id => text().withLength(min: 1, max: 32)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get code => text().withLength(min: 2, max: 32)();
  TextColumn get kind => textEnum<ClassKind>()();

  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();

  DateTimeColumn get lastChecked =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get room => text().withLength(min: 1, max: 32).nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, code, kind, startTime, endTime, room},
  ];

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Teacher extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 512)();
  TextColumn get classId =>
      text().references(UniversityClass, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, classId},
  ];
}

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  TextColumn get classId =>
      text().references(UniversityClass, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name, classId},
  ];
}

@DriftDatabase(tables: [UniversityClass, Teacher, Group])
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
    onUpgrade: (Migrator m, int from, int to) async {
      // Handle database upgrades if needed in the future
    },
    beforeOpen: (details) async {
      await database.customStatement('PRAGMA journal_mode=WAL');
      await database.customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

final database = AppDatabase();
