import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/pjatk_core.dart';
import 'package:pjatk_core/reconciler.dart';
import 'package:server/server.dart';

const reconcilePeriod = Duration(minutes: 30);

Future<void> backgroundWorker() async {
  final dao = ScheduleDao(scheduleDb);
  final reconciler = ScheduleReconciler(
    dao: dao,
    config: ReconcilerConfig(),
    talker: talker,
    parser: PjatkParser(),
  );

  while (true) {
    try {
      await reconciler.reconcileOnce();
      await Future.delayed(reconcilePeriod);

      talker.info(
        'Reconciliation cycle completed. Next run in ${reconcilePeriod.inMinutes} minutes.',
      );
    } catch (e, st) {
      talker.error('Error during reconciliation: $e', st);
    }
  }
}
