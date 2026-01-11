import 'package:flutter/foundation.dart';

class ApiConfig {

  static String get baseApiUrl {
    if (kIsWeb) {
      return 'https://pjatka.httpdebugger.workers.dev';
    } 

    return 'https://planzajec.pjwstk.edu.pl';
  }

  /// Base URL for PJATK schedule
  static String get scheduleEndpoint => '$baseApiUrl/PlanOgolny3.aspx';
  static String get groupRetrieverLoginEndpoint => '$baseApiUrl/Logowanie.aspx';
  

  static const groupRetrieverTargetEndpoint = 'TwojPlan.aspx';
}
