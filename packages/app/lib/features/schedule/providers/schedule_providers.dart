import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/parsing/parsing.dart';
import 'package:pjatka/features/database/providers.dart';
import 'package:pjatka/utils.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

final classesProvider = StreamProvider.autoDispose
    .family<List<ScheduledClass>, WatchFilters>((ref, filters) {
      final dao = ref.watch(scheduleDaoProvider);

      return dao.watchClasses(filters: filters);
    });

@Riverpod(keepAlive: true)
Future<void> classesReconciler(Ref ref) async {
  final settings = await ref.watch(settingsProvider);
  final dao = ref.watch(scheduleDaoProvider);

  final reconciler = ScheduleReconciler(
    dao: dao,
    config: ReconcilerConfig(
      maxDayOffset: settings.maxDateDaysOffset,
      minDateDaysOffset: settings.minDateDaysOffset,
      cacheTTLHours: settings.cacheTTLHours,
    ),
    talker: talker,
  );

  await reconciler.reconcileOnce();
}
