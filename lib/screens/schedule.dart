import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../features/schedule/providers/schedule_providers.dart';

class ScheduleDataSource extends CalendarDataSource {
  final ProviderContainer container;

  late final ProviderSubscription<Future<Map<DateTime, List<ScheduledClass>>>>
  subscription;

  ScheduleDataSource({required this.container}) {
    appointments = [];

    subscription = container
        .listen<Future<Map<DateTime, List<ScheduledClass>>>>(
          scheduleProvider.future,
          (previous, next) {
            talker.debug('Schedule data source received new schedule data');
            next.then((newClasses) {
              final newAppointments = <Appointment>[];

              for (final classesForDay in newClasses.values) {
                for (final classItem in classesForDay) {
                  newAppointments.add(_classToAppointment(classItem));
                }
              }

              talker.debug(
                'Loaded ${newAppointments.length} appointments for schedule',
              );
              appointments = newAppointments;
              notifyListeners(CalendarDataSourceAction.reset, appointments!);
            });
          },
        );
  }

  Appointment _classToAppointment(ScheduledClass classItem) {
    final startTime = classItem.start.toLocal();
    final endTime = classItem.end.toLocal();

    final color = _getColorForKind(classItem.kind);

    final location = classItem.place.when(
      online: () => 'Online',
      onSite: (room) => room,
    );

    final subject = '${classItem.name} (${classItem.code})';

    return Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      notes: 'Lecturer: ${classItem.lecturer}',
      location: location,
      color: color,
      id: classItem.classId,
    );
  }

  Color _getColorForKind(ClassKind kind) {
    return switch (kind) {
      ClassKind.lecture => Colors.blue,
      ClassKind.seminar => Colors.green,
      ClassKind.diplomaThesis => Colors.purple,
    };
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    talker.debug(
      'Loading more appointments from ${startDate.toIso8601String()} to ${endDate.toIso8601String()}',
    );
    final dateDiff = endDate.difference(startDate).inDays;

    for (int i = 0; i <= dateDiff; i += 1) {
      final day = startDate.add(Duration(days: i));
      talker.debug('Loading classes for date: ${day.toIso8601String()}');
      await container.read(scheduleProvider.notifier).getClassesForDate(day);
    }
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
          maxDate: DateTime.now().add(Duration(days: settings.maxDateDaysOffset)),
          showDatePickerButton: true,
          showCurrentTimeIndicator: true,
          todayHighlightColor: Colors.deepPurple,
          appointmentTextStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          // loadMoreWidgetBuilder: (context, loadMore) {
          //   loadMore();
          //   return Center(
          //     child: Padding(
          //       padding: EdgeInsets.all(16.0.w),
          //       child: CircularProgressIndicator(
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //     ),
          //   );
          // },
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TopLoader(),
        ),
      ],
    );
  }
}

final scheduleDestination = Destination(
  label: 'Schedule',
  icon: const Icon(Icons.schedule),
  selectedIcon: const Icon(Icons.schedule_outlined),
  main: AdaptiveBuilders(build: (context) => const ScheduleScreen()),
  tooltip: 'View your class schedule',
);
