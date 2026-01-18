import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/screens/groups_retriever/ics_resolver/ical_resolver.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class _FormException implements Exception {
  final String message;
  _FormException(this.message);

  @override
  String toString() => 'FormException: $message';
}

class _ICalGuide extends StatelessWidget {
  const _ICalGuide();

  static const _planUrl = 'https://planzajec.pjwstk.edu.pl/TwojPlan.aspx';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'How to export iCal file:',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 25.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              './assets/ical_guide/export.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: '1. Go to '),
              TextSpan(
                text: 'your timetable',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launchUrl(Uri.parse(_planUrl));
                  },
              ),
              const TextSpan(
                text:
                    '\n2. Scroll to bottom. Make sure "Aktualny semestr" is selected and press "Eksportuj do iCalendar".\n'
                    '3. Download the file to your device.\n'
                    '4. Use the "Choose iCal file" button below to select the downloaded file.',
              ),
            ],
          ),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ICalResolverForm extends HookConsumerWidget {
  final Completer<Set<String>> completer;

  const ICalResolverForm({super.key, required this.completer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final globalLoader = ref.watch(classesReconcilerProvider);

    final icalData = useState<String?>(null);
    final selectedFileName = useState<String?>(null);
    final analysisFutState = useState<Future<Set<String>>?>(null);
    final analysisFut = useFuture(analysisFutState.value);

    final isDbLoading = globalLoader.isLoading;
    final isFormDisabled =
        isDbLoading || analysisFut.connectionState == ConnectionState.waiting;

    final isLoading = analysisFut.connectionState == ConnectionState.waiting;

    Future<void> onAnalyze() async {
      final (fileName, data) = await _pickFile();
      selectedFileName.value = fileName;
      icalData.value = data;

      analysisFutState.value = _analyze(data);

      final groups = await analysisFutState.value!;

      completer.complete(groups);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 60.w),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _ICalGuide(),
                SizedBox(height: 3.h),
                Divider(),
                SizedBox(height: 2.h),
                if (isDbLoading)
                  _Loading(theme: theme),
                if (analysisFut.hasError)
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Container(
                      padding: EdgeInsets.all(1.5.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        analysisFut.error.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                Text(
                  'Selected file: ${selectedFileName.value ?? 'None'}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 2.h),
                FilledButton.icon(
                  onPressed: isFormDisabled ? null : onAnalyze,
                  icon: isLoading
                      ? SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : const Icon(Icons.upload_file),
                  label: isLoading
                      ? const Text('Analyzing...')
                      : const Text('Choose iCal file'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Container(
        padding: EdgeInsets.all(1.5.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 1.5.h,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Flexible(
              child: Text(
                'iCal analysis is unavailable until the full database finishes loading.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<(String, String)> _pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['ics', 'ical'],
    withData: true,
  );

  if (result == null || result.files.isEmpty) {
    throw _FormException('No file selected.');
  }

  final file = result.files.single;
  if (file.bytes == null) {
    throw _FormException('Could not read the selected file.');
  }

  return (file.name, utf8.decode(file.bytes!, allowMalformed: true));
}

Future<Set<String>> _analyze(String icalData) async {
  try {
    final groups = await resolveGroups(icalData);
    return groups;
  } catch (e, st) {
    talker.handle(e, st, 'iCal analysis failed');
    rethrow;
  }
}
