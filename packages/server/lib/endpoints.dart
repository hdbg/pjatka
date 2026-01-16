import 'dart:convert';

import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:relic/relic.dart';
import 'package:server/server.dart';

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

  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

  final classes = await dao
      .watchClasses(
        filters: WatchFilters(from: startOfDay, to: endOfDay),
      )
      .first;

  final resp = jsonEncode(classes.map((c) => c.toJson()).toList());

  return Response.ok(body: Body.fromString(resp));
}

Headers _corsHeaders(String? origin) => Headers.fromMap({
  Headers.accessControlAllowOriginHeader: [origin ?? '*'],
  Headers.accessControlAllowMethodsHeader: ['GET', 'POST', 'OPTIONS'],
  Headers.accessControlAllowHeadersHeader: [
    'Content-Type',
    'X-Requested-With',
    'X-MicrosoftAjax',
    'Cookie',
  ],
  Headers.accessControlAllowCredentialsHeader: ['true'],
  Headers.accessControlMaxAgeHeader: ['86400'],
});

final corsHeaders = _corsHeaders(null);

Middleware addCors() {
  return (final Handler innerHandler) {
    return (final Request ctx) async {
      final origin = ctx.headers['origin']?.firstOrNull;
      final headers = _corsHeaders(origin);

      if (ctx.method == Method.options) {
        return Response(204, headers: headers);
      }

      final result = await innerHandler(ctx);

      if (result case Response()) {
        return result.copyWith(headers: Headers.fromMap({
          ...result.headers,
          ...headers,
        }));
      }

      return result;
    };
  };
}
