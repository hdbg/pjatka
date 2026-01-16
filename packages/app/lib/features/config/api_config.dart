import 'package:flutter/foundation.dart';
import 'package:pjatk_core/api_config.dart'  as core;

class ApiConfig {
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: '');

    static const _directBase = core.ApiConfig.pjatkScheduleBase;

  static String get baseUrl => kIsWeb ? apiUrl : _directBase;

  static const pjatkLoginEndpoint = '/Logowanie.aspx';
  static const pjatkPersonalScheduleEndpoint = '/TwojPlan.aspx';

  static String get fullLoginUrl => '$baseUrl$pjatkLoginEndpoint';
  static String get fullPersonalScheduleUrl => '$baseUrl$pjatkPersonalScheduleEndpoint';
}
