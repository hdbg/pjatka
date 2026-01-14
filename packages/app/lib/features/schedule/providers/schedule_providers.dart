import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/parsing/parsing.dart';
import 'package:pjatk_core/reconciler.dart';
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

class _ServerReconciler implements Parser {
  static const url = 'https://pjatka.dev.mrkt.games:39083';

  Future<bool> isServerAvailable() async {
    try {
      final response = await dio.get('$url/healthz');
      return response.statusCode == 200;
    } catch (err, st) {
      talker.handle(err, st, 'Cache server is not available');
      return false;
    }
  }

  @override
  Future<List<ScheduledClass>> parseDay(DateTime date) async {
    final dateParam =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final resp = await dio.get(
      '$url/classes',
      queryParameters: {'date': dateParam},
    );

    if (resp.data is! List) {
      throw Exception('Invalid response from cache server');
    }

    return (resp.data as List)
        .map((e) => ScheduledClass.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
Future<Parser> bestAvailableParser(Ref ref) async {
  final serverReconciler = _ServerReconciler();

  if (await serverReconciler.isServerAvailable()) {
    talker.info('Using remote cache server for parsing');
    return serverReconciler;
  } else {
    talker.info('Using local parser for parsing');
    return PjatkParser();
  }
}

@Riverpod(keepAlive: true)
Future<void> classesReconciler(Ref ref) async {
  final settings = await ref.watch(settingsProvider);
  final dao = ref.watch(scheduleDaoProvider);
  final parser = await ref.watch(bestAvailableParserProvider.future);

  final reconciler = ScheduleReconciler(
    dao: dao,
    config: ReconcilerConfig(
      maxDayOffset: settings.maxDateDaysOffset,
      minDateDaysOffset: settings.minDateDaysOffset,
      cacheTTLHours: settings.cacheTTLHours,
    ),
    parser: parser,
    talker: talker,
  );

  await reconciler.reconcileOnce();
}
