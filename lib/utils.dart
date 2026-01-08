import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

final Duration transitionDuration = Duration(milliseconds: 200);

final talker = Talker(
  settings: TalkerSettings(
    enabled: true,
    useHistory: true,
    maxHistoryItems: 100,
    useConsoleLogs: true,
  ),
);

final dio = Dio();
