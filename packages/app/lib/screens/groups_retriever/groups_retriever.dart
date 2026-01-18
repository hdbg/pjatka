import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pjatka/features/config/api_config.dart';
import 'package:pjatka/utils.dart';
import 'package:html/parser.dart' as html_parser;

Set<String> _parseGroupsFromHtml(String html) {
  final document = html_parser.parse(html);
  final groupTable = document.querySelector('.rlbGroup.rlbGroupRight');

  if (groupTable == null) {
    throw Exception('Could not find group table on page');
  }

  final groupSpans = groupTable.querySelectorAll('span.rlbText');
  return groupSpans
      .map((e) => e.text.trim())
      .where((e) => e.isNotEmpty)
      .toSet();
}

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
    if (parts.length < 2) {
      continue;
    }
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
        if (group.length < 2) {
          return false;
        }
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

class _GroupsRetrieverNative extends StatelessWidget {
  final Completer<Set<String>> onDone;
  const _GroupsRetrieverNative({required this.onDone});

  @override
  Widget build(BuildContext context) {
    final webview = InAppWebView(
      onLoadStop: (controller, url) async {
        talker.debug('Page loaded: $url');

        if (!url.toString().trim().contains(
          ApiConfig.pjatkPersonalScheduleEndpoint,
        )) {
          return;
        }

        talker.debug('Reached target endpoint, extracting group info');

        try {
          final html = await controller.getHtml();
          if (html == null) {
            onDone.completeError('Failed to get page HTML');
            return;
          }

          final groups = _parseGroupsFromHtml(html);
          final filteredGroups = _filterGroups(groups);

          onDone.complete(filteredGroups);
        } catch (e, st) {
          talker.handle(e, st, 'Error extracting groups');
          onDone.completeError(e);
        }
      },
      initialUrlRequest: URLRequest(url: WebUri(ApiConfig.fullLoginUrl)),
    );

    return webview;
  }
}

Future<Set<String>> showGroupsRetriever(BuildContext context) {
  final completer = Completer<Set<String>>();

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Retrieve Groups')),
        body: kIsWeb
            ? Center(
                child: Text(
                  'Credentials-based group retrieval is not supported on web platform.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            : _GroupsRetrieverNative(onDone: completer),
      ),
    ),
  );

   completer.future
      .then((_) {
        Navigator.of(context).pop();
      })
      .catchError((error) {
        talker.handle(error, null, 'Error retrieving groups');
        Navigator.of(context).pop();
        throw error;
      });

  return completer.future;
}
