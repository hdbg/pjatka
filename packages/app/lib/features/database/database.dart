
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pjatk_core/database/database.dart';

final scheduleDb = ScheduleDatabase(  
     driftDatabase(
      name: 'pjatkapp',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    )
);
