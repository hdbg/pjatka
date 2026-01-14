import 'dart:io';

import 'package:relic/io_adapter.dart';
import 'package:relic/relic.dart';
import 'package:server/endpoints.dart';
import 'package:server/reconcile.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main(List<String> arguments) async {
  tz.initializeTimeZones();

  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;

  // Start the background reconciliation worker
  final _ = backgroundWorker();

  final app = RelicApp()
    ..use('/', addCors())
    ..use('/', logRequests())
    ..get('/classes', classesHandler)
    ..get('/healthz', (request) => Response.ok(body: Body.fromString('OK\n')))
    ..fallback = respondWith(
      (_) => Response.notFound(
        body: Body.fromString("Sorry, that doesn't compute.\n"),
      ),
    );

  await app.serve(address: InternetAddress.anyIPv4, port: port);
}
