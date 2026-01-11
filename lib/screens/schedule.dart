import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/database/dao/schedule_dao.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../features/schedule/providers/schedule_providers.dart';

String _getPlaceDescription(ClassPlace place) {
  return place.when(online: () => 'Online', onSite: (room) => room);
}

Color _getColorForKind(ClassKind kind) {
  return switch (kind) {
    ClassKind.lecture => Colors.blue,
    ClassKind.seminar => Colors.green,
    ClassKind.diplomaThesis => Colors.purple,
  };
}

// Exploit the fact that it can be casted to Appointment later, so calendar is compatible
class _CustomAppointment extends Appointment {
  final ScheduledClass scheduledClass;

  _CustomAppointment(this.scheduledClass)
    : super(
        startTime: scheduledClass.start.toLocal(),
        endTime: scheduledClass.end.toLocal(),
        subject:
            '${scheduledClass.code} - ${_getPlaceDescription(scheduledClass.place)}',
        location: _getPlaceDescription(scheduledClass.place),
        color: _getColorForKind(scheduledClass.kind),
      );
}

class ScheduleDataSource extends CalendarDataSource {
  final ProviderContainer container;

  late final ProviderSubscription<Future<List<ScheduledClass>>> subscription;

  ScheduleDataSource({required this.container}) {
    appointments = [];

    subscription = container.listen<Future<List<ScheduledClass>>>(
      userClassesProvider.future,
      (previous, next) {
        next.then((newClasses) {
          if (newClasses.isEmpty) {
            return;
          }
          final newAppointments = <Appointment>[];

          for (final classItem in newClasses) {
            newAppointments.add(_CustomAppointment(classItem));
          }

          talker.debug(
            'Loaded ${newAppointments.length} appointments for schedule',
          );
          appointments = newAppointments;
          notifyListeners(CalendarDataSourceAction.reset, appointments!);
        });
      },
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.close();
  }
}

class TopLoader extends ConsumerWidget {
  const TopLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(globalLoaderProvider).isLoading;

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

/// Main schedule screen displaying classes
class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Stack(
      children: [
        SfCalendar(
          view: CalendarView.schedule,
          dataSource: ScheduleDataSource(container: ref.container),
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
            CalendarView.schedule,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
          ],
          firstDayOfWeek: 1,
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 8,
            endHour: 21,
            timeInterval: Duration(minutes: 30),
            timeFormat: 'HH:mm',
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
          onTap: (calendarTapDetails) {
            if (calendarTapDetails.targetElement ==
                    CalendarElement.appointment &&
                calendarTapDetails.appointments != null) {
              final appointment =
                  calendarTapDetails.appointments!.first as _CustomAppointment;

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
  final _CustomAppointment appointment;
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
        _DetailRow(
          label: 'Location',
          value: _getPlaceDescription(appointment.scheduledClass.place),
        ),
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
  _CustomAppointment appointment,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
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
            await ScheduleDao.ignoreSubject(
              name: appointment.scheduledClass.name,
              code: appointment.scheduledClass.code,
              kind: appointment.scheduledClass.kind,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

final scheduleDestination = Destination(
  label: 'Schedule',
  icon: const Icon(Icons.schedule),
  selectedIcon: const Icon(Icons.schedule_outlined),
  main: AdaptiveBuilders(build: (context) => const ScheduleScreen()),
  tooltip: 'View your class schedule',
);
