import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/screens/groups_retriever/ical_inductor/ical_inductor.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';

class _FormException implements Exception {
  final String message;
  _FormException(this.message);

  @override
  String toString() => 'FormException: $message';
}

class ICalInductorForm extends HookConsumerWidget {
  final Completer<Set<String>> completer;

  const ICalInductorForm({super.key, required this.completer});

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

    return Center(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isDbLoading)
              Text(
                'iCal analysis is unavailable until the full database finishes loading.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            if (analysisFut.hasError)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  analysisFut.error.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            SizedBox(height: 2.h),
            Text(
              'Selected file: ${selectedFileName.value ?? 'None'}',
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                OutlinedButton.icon(
                  onPressed: isFormDisabled
                      ? null
                      : () async {
                          final (fileName, data) = await _pickFile();
                          selectedFileName.value = fileName;
                          icalData.value = data;

                          analysisFutState.value = _analyze(data);
                        },
                  icon: const Icon(Icons.upload_file),
                  label: isLoading
                      ? const Text('Analyzing...')
                      : const Text('Choose iCal file'),
                ),
                if (analysisFut.connectionState == ConnectionState.waiting)
                  SizedBox.square(
                    dimension: 4.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
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
