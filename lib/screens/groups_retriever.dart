import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/config/api_config.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/utils.dart';

final _jsPayload = '''
const student_group_table=document.querySelector(".rlbGroup.rlbGroupRight");var groups=[];for(const a of student_group_table.querySelectorAll("span.rlbText")){const b=a.innerText;groups.push(b)};groups
''';

class GroupsRetriever extends ConsumerWidget {
  final Completer onDone;
  const GroupsRetriever({super.key, required this.onDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webview = InAppWebView(
      onLoadStop: (controller, url) {
        talker.debug('Page loaded: $url');

        if (url.toString().trim() !=
            ApiConfig.groupRetrieverTargetEndpoint.trim()) {
          return;
        }

        talker.debug('Reached target endpoint, extracting group info');

        controller
            .evaluateJavascript(source: _jsPayload)
            .then((result) {
              if (result is! List<dynamic>) {
                talker.warning(
                  'Unexpected result type when extracting groups: ${result.runtimeType}',
                );
                onDone.completeError(
                  'Unexpected result type when extracting groups',
                );
                return;
              }
              final groups = result
                  .whereType<String>()
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toSet();

              ref.read(settingsProvider.notifier).replaceGroups(groups);

              onDone.complete();
              talker.debug('Extracted & updated groups to: $groups');
            })
            .catchError((error) {
              talker.handle(error, null, 'Error extracting groups');
              onDone.completeError(error);
            });
      },
      initialUrlRequest: URLRequest(
        url: WebUri(ApiConfig.groupRetrieverLoginEndpoint),
      ),
    );

    return webview;
  }
}

Future<void> showGroupsRetriever(BuildContext context) {
  final completer = Completer<void>();

  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => GroupsRetriever(onDone: completer)),
  );

  return completer.future
      .then((_) {
        Navigator.of(context).pop();
      })
      .catchError((error) {
        Navigator.of(context).pop();
        throw error;
      });
}
