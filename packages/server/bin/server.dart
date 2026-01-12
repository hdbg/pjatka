import 'package:relic/io_adapter.dart';
import 'package:relic/relic.dart';
import 'package:server/endpoints.dart';
import 'package:server/reconcile.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main(List<String> arguments) async {
  tz.initializeTimeZones();

  // Start the background reconciliation worker
  final _ = backgroundWorker();

  final app = RelicApp()
    ..get('/classes', classesHandler)
    ..use('/', logRequests())
    ..fallback = respondWith(
      (_) => Response.notFound(
        body: Body.fromString("Sorry, that doesn't compute.\n"),
      ),
    );

  await app.serve();
}
