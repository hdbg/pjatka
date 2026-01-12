import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/config/api_config.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/utils.dart';

final _jsPayload = '''
const student_group_table=document.querySelector(".rlbGroup.rlbGroupRight");var groups=[];for(const a of student_group_table.querySelectorAll("span.rlbText")){const b=a.innerText;groups.push(b)};groups
''';

/* 
PJATK's website returns all student groups, including past ones.
This function:
- Find highest semester groups (second element if spaced by space, prefixed with 'I.')
- Leaves only groups with last semester

Special exclusion is groups, where last element is "(ITN)".
Those are repetition groups, which are relevant.
They should go through the same filtering as regular groups, but separately
*/
Set<String> _filterGroups(Set<String> groups) {
  const semesterPrefix = 'I.';
  const repetitionSuffix = '(ITN)';

  final splitted = groups.map((e) => e.split(' ')).toList();
  var highestSemester = null as int?;
  var highestRepSemester = null as int?;

  for (final parts in splitted) {
    final semesterPart = parts[1].replaceAll(semesterPrefix, '');
    final semester = int.tryParse(semesterPart);
    if (semester == null) continue;

    if (parts.last == repetitionSuffix) {
      if (highestRepSemester == null || semester > highestRepSemester) {
        highestRepSemester = semester;
      }
    } else {
      if (highestSemester == null || semester > highestSemester) {
        highestSemester = semester;
      }
    }
  }

  return splitted
      .where((group) {
        final semesterPart = group[1].replaceAll(semesterPrefix, '');
        final semester = int.tryParse(semesterPart);
        if (group.last == repetitionSuffix) {
          return semester == highestRepSemester;
        } else {
          return semester == highestSemester;
        }
      })
      .map((e) {
        e.removeWhere((element) => element == repetitionSuffix);
        return e.join(' ').trim();
      })
      .toSet();
}

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

              final filteredGroups = _filterGroups(groups);

              ref.read(settingsProvider.notifier).replaceGroups(filteredGroups);

              onDone.complete();
              talker.debug('Extracted & updated groups to: $filteredGroups');
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
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Retrieve Groups')),
        body: GroupsRetriever(onDone: completer),
      ),
    ),
  );

  return completer.future
      .then((_) {
        Navigator.of(context).pop();
      })
      .catchError((error) {
        talker.handle(error, null, 'Error retrieving groups');
        Navigator.of(context).pop();
        throw error;
      });
}
