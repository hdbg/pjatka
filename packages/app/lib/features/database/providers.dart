import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
ScheduleDao scheduleDao(Ref ref) {
  return ScheduleDao(scheduleDb, talker: talker);
}
