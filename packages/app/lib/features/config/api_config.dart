import 'package:flutter/foundation.dart';
import 'package:pjatk_core/api_config.dart' as core;

class ApiConfig {
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: '');

  static const _directBase = core.ApiConfig.pjatkScheduleBase;

  static String get baseUrl {
    final url = kIsWeb ? apiUrl : _directBase;
    _assertHttpsInRelease(url);
    return url;
  }

  static const pjatkLoginEndpoint = '/Logowanie.aspx';
  static const pjatkPersonalScheduleEndpoint = '/TwojPlan.aspx';
  static const pjatkLogoutEndpoint = 'Wylogowanie.aspx';

  static String get fullLoginUrl => '$baseUrl$pjatkLoginEndpoint';
  static String get fullPersonalScheduleUrl =>
      '$baseUrl$pjatkPersonalScheduleEndpoint';

  static void _assertHttpsInRelease(String url) {
    if (kReleaseMode && url.isNotEmpty && !url.startsWith('https://')) {
      throw StateError(
        'API_URL must use HTTPS in release mode. Got: $url',
      );
    }
  }
}
