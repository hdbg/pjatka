export 'parsing/parsing.dart';
export 'database/database.dart';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

final talker = Talker(
  settings: TalkerSettings(
    enabled: true,
    useHistory: true,
    maxHistoryItems: 100,
    useConsoleLogs: true,
  ),
);

final dio = Dio();


