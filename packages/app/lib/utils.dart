import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
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

void notifyError(BuildContext ctx, String title, String message) {
  final colorScheme = Theme.of(ctx).colorScheme;

  ElegantNotification.error(
    width: 360,
    background: colorScheme.surface,
    toastDuration: Duration(seconds: 5),
    stackedOptions: StackedOptions(
      key: 'topRight',
      type: StackedType.below,
      itemOffset: Offset(0, 5),
    ),
    position: Alignment.topRight,
    animation: AnimationType.fromRight,
    title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
    description: Text(message, style: TextStyle(color: colorScheme.onSurface)),
    onDismiss: () {},
  ).show(ctx);
}
