import 'dart:io';

import 'package:drift/native.dart';
import 'package:pjatk_core/database/database.dart';
import 'package:pjatk_core/pjatk_core.dart';

final scheduleDb = ScheduleDatabase(
  NativeDatabase.createInBackground(File('schedule_db.sqlite')),
);
