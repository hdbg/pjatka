import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatk_core/database/database.dart';
import 'package:pjatk_core/database/models.dart';
import 'package:pjatk_core/parsing/parsing.dart';
import 'package:pjatk_core/reconciler.dart';
import 'package:pjatka/features/config/api_config.dart';
import 'package:pjatka/features/config/constants.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/features/database/providers.dart';
import 'package:pjatka/utils.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

final classesProvider = StreamProvider.autoDispose
    .family<List<ScheduledClass>, WatchFilters>((ref, filters) {
      final dao = ref.watch(scheduleDaoProvider);

      return dao.watchClasses(filters: filters);
    });

class _ServerReconciler implements Parser {

  Future<bool> isServerAvailable() async {
    try {
      final response = await dio.get('${ApiConfig.apiUrl}/healthz');
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
      '${ApiConfig.apiUrl}/classes',
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
Future<Parser?> bestAvailableParser(Ref ref) async {
  final serverReconciler = _ServerReconciler();

  if (await serverReconciler.isServerAvailable()) {
    talker.info('Using remote cache server for parsing');
    return serverReconciler;
  }

  if (kIsWeb) {
    talker.warning('Cache server is not available on web');
    return null;
  }

  talker.info('Using local parser for parsing');
  return PjatkParser(talker: talker);
}

enum ReconcileState {
  success,
  serverUnavailable,
}

@Riverpod(keepAlive: true)
class ClassesReconciler extends _$ClassesReconciler {
  Timer? _retryTimer;
  SettingsState? _previousSettings;

  @override
  Future<ReconcileState> build() async {
    ref.onDispose(() => _retryTimer?.cancel());

    final settings = await ref.watch(settingsProvider);
    final parser = await ref.watch(bestAvailableParserProvider.future);

    if (parser == null) {
      _retryTimer?.cancel();
      _retryTimer = Timer(serverRetryCooldown, () {
        ref.invalidateSelf();
      });
      return ReconcileState.serverUnavailable;
    }

    final previousSettings = _previousSettings;
    _previousSettings = settings;

    await scheduleDb.computeWithDatabase(
      computation: (db) async {
        final reconciler = ScheduleReconciler(
          dao: ScheduleDao(db, talker: talker),
          config: ReconcilerConfig(
            maxDayOffset: settings.maxDateDaysOffset,
            minDateDaysOffset: settings.minDateDaysOffset,
            cacheTTLMinutes: settings.cacheTTLMinutes,
            soonDaysThreshold: settings.soonDaysThreshold,
          ),
          parser: parser,
          talker: talker,
        );

        if (previousSettings != null &&
            (settings.cacheTTLMinutes < previousSettings.cacheTTLMinutes ||
                settings.soonDaysThreshold >
                    previousSettings.soonDaysThreshold)) {
          await reconciler.invalidateCachedDays(now: DateTime.now());
        }

        await reconciler.reconcileOnce();
      },
      connect: (connection) => ScheduleDatabase(connection),
    );

    return ReconcileState.success;
  }
}
