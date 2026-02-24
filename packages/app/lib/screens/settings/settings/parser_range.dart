import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:sizer/sizer.dart';

class _ParserRangeHeader extends StatelessWidget {
  const _ParserRangeHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.date_range,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parser Range',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Configure the date range for schedule parsing',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ParserRangeSettings extends HookConsumerWidget {
  const ParserRangeSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        children: [
          _ParserRangeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _MinOffsetField(),
                  SizedBox(height: 16),
                  _MaxOffsetField(),
                  SizedBox(height: 16),
                  _CacheTTLField(),
                  SizedBox(height: 24),
                  _InfoCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MinOffsetField extends HookConsumerWidget {
  const _MinOffsetField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final settings = ref.watch(settingsProvider);
    final textController = useTextEditingController(
      text: settings.minDateDaysOffset.toString(),
    );

    useEffect(() {
      textController.text = settings.minDateDaysOffset.toString();
      return null;
    }, [settings.minDateDaysOffset]);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Minimum Days Offset',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'How many days in the past to fetch schedules',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Days',
                hintText: 'Enter number of days...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixText: 'days',
              ),
              onSubmitted: (value) {
                final offset = int.tryParse(value);
                if (offset != null && offset >= 0) {
                  ref.read(settingsProvider.notifier).setMinDateDaysOffset(offset);
                }
              },
              onChanged: (value) {
                final offset = int.tryParse(value);
                if (offset != null && offset >= 0) {
                  ref.read(settingsProvider.notifier).setMinDateDaysOffset(offset);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MaxOffsetField extends HookConsumerWidget {
  const _MaxOffsetField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final settings = ref.watch(settingsProvider);
    final textController = useTextEditingController(
      text: settings.maxDateDaysOffset.toString(),
    );

    useEffect(() {
      textController.text = settings.maxDateDaysOffset.toString();
      return null;
    }, [settings.maxDateDaysOffset]);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Maximum Days Offset',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'How many days in the future to fetch schedules',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Days',
                hintText: 'Enter number of days...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixText: 'days',
              ),
              onSubmitted: (value) {
                final offset = int.tryParse(value);
                if (offset != null && offset >= 0) {
                  ref.read(settingsProvider.notifier).setMaxDateDaysOffset(offset);
                }
              },
              onChanged: (value) {
                final offset = int.tryParse(value);
                if (offset != null && offset >= 0) {
                  ref.read(settingsProvider.notifier).setMaxDateDaysOffset(offset);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _formatMinutes(int minutes) {
  if (minutes <= 60) return '$minutes min';
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;
  if (remainingMinutes == 0) return '$hours h';
  return '$hours h $remainingMinutes min';
}

class _CacheTTLField extends HookConsumerWidget {
  const _CacheTTLField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final settings = ref.watch(settingsProvider);
    final sliderValue = useState(settings.cacheTTLMinutes.toDouble());

    useEffect(() {
      sliderValue.value = settings.cacheTTLMinutes.toDouble();
      return null;
    }, [settings.cacheTTLMinutes]);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.refresh,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Refresh Interval',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'How often to re-fetch schedules from the server',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Flexible(
                  flex: 10,
                  child: Slider(
                    value: sliderValue.value,
                    min: 1,
                    max: 1440,
                    divisions: 1439,
                    label: _formatMinutes(sliderValue.value.round()),
                    onChanged: (value) {
                      sliderValue.value = value;
                    },
                    onChangeEnd: (value) {
                      ref
                          .read(settingsProvider.notifier)
                          .setCacheTTLMinutes(value.round());
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    _formatMinutes(sliderValue.value.round()),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'These settings control the date range and refresh interval for schedule parsing. '
              'The minimum offset determines how far back in time to fetch schedules, '
              'the maximum offset determines how far into the future, '
              'and the refresh interval controls how often cached schedules are re-fetched.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final parserRangeSetting = Setting(
  title: 'Parser Range',
  icon: Icons.date_range,
  description: 'Configure schedule date range',
  builder: (context) => const ParserRangeSettings(),
);
