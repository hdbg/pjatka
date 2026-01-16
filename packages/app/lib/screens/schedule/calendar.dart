import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatk_core/database/dao/schedule_dao.dart';
import 'package:pjatka/features/database/providers.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/screens/schedule/calendar_adapter.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TopLoader extends ConsumerWidget {
  const TopLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(classesReconcilerProvider).isLoading;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading
          ? LinearProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withAlpha(30),
              minHeight: 0.5.h,
            )
          : const SizedBox.shrink(),
    );
  }
}

class Calendar extends HookConsumerWidget {
  final WatchFilters filters;
  final List<CalendarView> allowedViews;

  const Calendar({
    super.key,
    required this.filters,
    this.allowedViews = const [
      CalendarView.day,
      CalendarView.week,
      CalendarView.month,
      CalendarView.schedule,
      CalendarView.timelineDay,
      CalendarView.timelineWeek,
    ],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    final dataSource = useMemoized(
      () => ScheduleDataSource(
        container: ProviderScope.containerOf(context),
        baseFilters: filters,
      ),
      [filters],
    );
    useEffect(() => dataSource.dispose, [dataSource]);

    return Stack(
      children: [
        SfCalendar(
          view: allowedViews.first,
          dataSource: dataSource,
          allowedViews: allowedViews,
          firstDayOfWeek: 1,
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 8,
            endHour: 21,
            timeInterval: Duration(minutes: 15),
            timeFormat: 'HH:mm',
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
          ),
          minDate: DateTime.now().subtract(
            Duration(days: settings.minDateDaysOffset),
          ),
          maxDate: DateTime.now().add(
            Duration(days: settings.maxDateDaysOffset),
          ),
          showDatePickerButton: true,
          showCurrentTimeIndicator: true,
          todayHighlightColor: Colors.deepPurple,
          showNavigationArrow: true,
          showTodayButton: true,
          appointmentTextStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          appointmentTimeTextFormat: 'HH:mm',
          onViewChanged: (details) {
            dataSource.updateVisibleDates(details.visibleDates);
          },
          onTap: (calendarTapDetails) {
            if (calendarTapDetails.targetElement ==
                    CalendarElement.appointment &&
                calendarTapDetails.appointments != null) {
              final appointment =
                  calendarTapDetails.appointments!.first as AppointmentAdapter;

              _showClassDetailsDialog(context, appointment);
            }
          },
        ),
        const Positioned(top: 0, left: 0, right: 0, child: TopLoader()),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ClassDetailsPopup extends StatelessWidget {
  final AppointmentAdapter appointment;
  const _ClassDetailsPopup({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final groups = appointment.scheduledClass.groups.join(', ');

    // Calculate duration
    final duration = appointment.endTime.difference(appointment.startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final durationText = hours > 0
        ? '${hours}h ${minutes}min'
        : '${minutes}min';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailRow(label: 'Code', value: appointment.scheduledClass.code),
        _DetailRow(label: 'Type', value: appointment.scheduledClass.kind.name),
        _DetailRow(label: 'Location', value: appointment.place),
        _DetailRow(
          label: 'Teacher',
          value: appointment.scheduledClass.lecturer,
        ),
        _DetailRow(label: 'Groups', value: groups),
        _DetailRow(label: 'Duration', value: durationText),
      ],
    );
  }
}

void _showClassDetailsDialog(
  BuildContext context,
  AppointmentAdapter appointment,
) {
  showDialog(
    context: context,
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        return AlertDialog(
          title: Text(appointment.scheduledClass.name),
          content: SingleChildScrollView(
            child: _ClassDetailsPopup(appointment: appointment),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              child: const Text('Ignore Class'),
              onPressed: () async {
                await ref
                    .read(scheduleDaoProvider)
                    .ignoreSubject(
                      name: appointment.scheduledClass.name,
                      code: appointment.scheduledClass.code,
                      kind: appointment.scheduledClass.kind,
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ),
  );
}
