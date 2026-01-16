import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/config/api_config.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/utils.dart';
import 'package:pjatk_core/parsing/parsers/asp_emulator.dart';
import 'package:html/parser.dart' as html_parser;

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

class _GroupsRetrieverNative extends ConsumerWidget {
  final Completer onDone;
  const _GroupsRetrieverNative({required this.onDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webview = InAppWebView(
      onLoadStop: (controller, url) {
        const _target = 'TwojPlan.aspx';

        talker.debug('Page loaded: $url');

        if (!url.toString().trim().contains(_target)) {
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

class _GroupsRetrieverWeb extends HookConsumerWidget {
  final Completer onDone;
  const _GroupsRetrieverWeb({required this.onDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final error = useState<String?>(null);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      error.value = null;

      try {
        final emulator = AspEmulator(
          ApiConfig.groupRetrieverProxyBase,
          talker: talker,
        );

        final initialResponse = await emulator.request(
          const AspRequest(endpoint: '/Logowanie.aspx', kind: RequestKind.initial()),
        );

        if (initialResponse.statusCode != 200) {
          throw Exception('Failed to load login page: ${initialResponse.statusCode}');
        }

        final loginResponse = await emulator.request(
          AspRequest(
            endpoint: '/Logowanie.aspx',
            kind: const RequestKind.event(target: '', argument: ''),
            stateOverride: {
              // TODO: Possible will have to update these values if PJATK changes something
              'RadScriptManager1_TSM': ';;System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35:en-US:64455737-15dd-482f-b336-7074c5c53f91:ea597d4b:b25378d2',
              r'ctl00$ContentPlaceHolder1$Login1$UserName': usernameController.text,
              r'ctl00$ContentPlaceHolder1$Login1$Password': passwordController.text,
              r'ctl00$ContentPlaceHolder1$Login1$LoginButton': 'Zaloguj',
            },
          ),
        );

        talker.debug('Login response status: ${loginResponse.statusCode}');

        if (loginResponse.statusCode != 302 && loginResponse.statusCode != 200) {
          throw Exception('Login failed with status: ${loginResponse.statusCode}');
        }

        final planResponse = await emulator.request(
          const AspRequest(endpoint: '/TwojPlan.aspx', kind: RequestKind.initial()),
        );

        if (planResponse.statusCode != 200 || planResponse.body == null) {
          throw Exception('Failed to load TwojPlan.aspx: ${planResponse.statusCode}');
        }

        final document = html_parser.parse(planResponse.body!);
        final groupTable = document.querySelector('.rlbGroup.rlbGroupRight');

        if (groupTable == null) {
          throw Exception('Could not find group table on page');
        }

        final groupSpans = groupTable.querySelectorAll('span.rlbText');
        final groups = groupSpans
            .map((e) => e.text.trim())
            .where((e) => e.isNotEmpty)
            .toSet();

        final filteredGroups = _filterGroups(groups);
        talker.debug('Extracted groups: $filteredGroups');

        ref.read(settingsProvider.notifier).replaceGroups(filteredGroups);
        onDone.complete();
      } catch (e, st) {
        talker.handle(e, st, 'Group retrieval failed');
        error.value = e.toString();
        isLoading.value = false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.orange.shade100,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade800),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your credentials will not be stored and are used only to retrieve your groups.',
                        style: TextStyle(color: Colors.orange.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 's12345',
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              enabled: !isLoading.value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              enabled: !isLoading.value,
            ),
            const SizedBox(height: 24),
            if (error.value != null) ...[
              Text(error.value!, style: TextStyle(color: theme.colorScheme.error)),
              const SizedBox(height: 16),
            ],
            FilledButton(
              onPressed: isLoading.value ? null : submit,
              child: isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showGroupsRetriever(BuildContext context) {
  final completer = Completer<void>();

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Retrieve Groups')),
        body: kIsWeb
            ? _GroupsRetrieverWeb(onDone: completer)
            : _GroupsRetrieverNative(onDone: completer),
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
