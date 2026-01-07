import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

part 'database.g.dart';

class UniversityClass extends Table {
  TextColumn get id => text().withLength(min: 1, max: 32)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get code => text().withLength(min: 2, max: 32)();
  TextColumn get kind => textEnum<ClassKind>()(); 

  TextColumn? get room => text().withLength(min: 1, max: 32).nullable()();

  IntColumn get teacherId => integer().nullable().references(Teacher, #id)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ClassGroup extends Table {
  TextColumn get id => text().withLength(min: 1, max: 32)();
  TextColumn get classId => text().withLength(min: 1, max: 32).references(UniversityClass, #id)();
}

class Teacher extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 128)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ClassMeetings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get classId => text().withLength(min: 1, max: 32).references(UniversityClass, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();

  DateTimeColumn get lastChecked => dateTime().withDefault(currentDateAndTime)();
}


@DriftDatabase(tables: [UniversityClass, ClassGroup, Teacher, ClassMeetings])
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
    );
  }
}

final database = AppDatabase();