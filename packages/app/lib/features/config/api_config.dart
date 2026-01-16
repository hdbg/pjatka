import 'package:flutter/foundation.dart';

class ApiConfig {
  static const _proxyBase = 'http://localhost:8080';

  static const _directLoginEndpoint = 'https://planzajec.pjwstk.edu.pl/Logowanie.aspx';
  static const _directTargetEndpoint = 'https://planzajec.pjwstk.edu.pl/TwojPlan.aspx';

  static String get groupRetrieverProxyBase => _proxyBase;

  static String get groupRetrieverLoginEndpoint =>
      kIsWeb ? '$_proxyBase/Logowanie.aspx' : _directLoginEndpoint;
}
