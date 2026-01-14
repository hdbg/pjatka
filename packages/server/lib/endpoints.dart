import 'dart:convert';

import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:relic/relic.dart';
import 'package:server/server.dart';

Response helloHandler(final Request req) {
  final name = req.rawPathParameters[#name];
  final age = int.parse(req.rawPathParameters[#age]!);

  return Response.ok(
    body: Body.fromString('Hello, $name! To think you are $age years old.\n'),
  );
}

Future<Response> classesHandler(final Request req) async {
  final dao = ScheduleDao(scheduleDb, talker: talker);

  final dateStr = req.queryParameters.raw["date"];

  if (dateStr == null) {
    return Response.badRequest(
      body: Body.fromString('Missing required query parameter: date\n'),
    );
  }

  final date = DateTime.tryParse(dateStr);

  if (date == null) {
    return Response.badRequest(
      body: Body.fromString('Invalid date format. Use YYYY-MM-DD.\n'),
    );
  }

  final classes = await dao
      .watchClasses(
        filters: WatchFilters(from: date, to: date),
      )
      .first;

  final resp = jsonEncode(classes.map((c) => c.toJson()).toList());

  return Response.ok(body: Body.fromString(resp));
}

final corsHeaders = Headers.fromMap({
  Headers.accessControlAllowOriginHeader: ['*'],
  Headers.accessControlAllowMethodsHeader: ['GET', 'POST', 'OPTIONS'],
  Headers.accessControlAllowHeadersHeader: ['Content-Type'],
  Headers.accessControlMaxAgeHeader: ['86400'],
  Headers.contentTypeHeader: ['application/json'],
});

Middleware addCors() {
  return (final Handler innerHandler) {
    return (final Request ctx) async {
      final result = await innerHandler(ctx);

      if (result case Response()) {
        return result.copyWith(headers: Headers.fromMap({
          ...result.headers,
          ...corsHeaders,
        }));
      }

      return result;
    };
  };
}
