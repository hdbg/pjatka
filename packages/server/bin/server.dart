import 'dart:io';

import 'package:drift/native.dart';
import 'package:pjatk_core/database/database.dart';
import 'package:relic/io_adapter.dart';
import 'package:relic/relic.dart';
import 'package:server/endpoints.dart';
import 'package:server/proxy.dart';
import 'package:server/reconcile.dart';
import 'package:server/server.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main(List<String> arguments) async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;
  final dbPath = Platform.environment['DB_PATH'] ?? 'schedule_db.sqlite';

  scheduleDb = ScheduleDatabase(
    NativeDatabase.createInBackground(File(dbPath)),
  );

  tz.initializeTimeZones();

  // Start the background reconciliation worker
  final _ = backgroundWorker();

  final app = RelicApp()
    ..use('/', addCors())
    ..use('/', logRequests())
    ..options('/**', (_) => Response(204))
    ..get('/classes', classesHandler)
    ..get('/healthz', (request) => Response.ok(body: Body.fromString('OK\n')))
    ..get('/**', proxyHandler)
    ..post('/**', proxyHandler)
    ..fallback = respondWith(
      (_) => Response.notFound(
        body: Body.fromString("Sorry, that doesn't compute.\n"),
      ),
    );

  await app.serve(address: InternetAddress.anyIPv4, port: port);
}
