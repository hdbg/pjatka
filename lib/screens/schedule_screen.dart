import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/schedule/models.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../features/schedule/providers/schedule_providers.dart';
import '../features/schedule/data/schedule_data_source.dart';

/// Main schedule screen displaying today's classes
class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsync = ref.watch(todayClassesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Schedule'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: classesAsync.when(
        data: (classes) => _buildScheduleView(classes),
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error, ref),
      ),
    );
  }

  /// Build the calendar view with classes
  Widget _buildScheduleView(List<ScheduledClass> classes) {
    if (classes.isEmpty) {
      return _buildEmptyState();
    }

    return SfCalendar(
      view: CalendarView.schedule,
      dataSource: ScheduleDataSource(classes),
      timeSlotViewSettings: const TimeSlotViewSettings(
        startHour: 8,
        endHour: 20,
        timeInterval: Duration(minutes: 30),
        timeFormat: 'HH:mm',
      ),
      showDatePickerButton: true,
      showCurrentTimeIndicator: true,
      todayHighlightColor: Colors.deepPurple,
      appointmentTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      
    );
  }

  /// Loading state with spinner
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading today\'s schedule...'),
        ],
      ),
    );
  }

  /// Empty state when no classes found
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No classes today!',
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Enjoy your free day',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  /// Error state with retry button
  Widget _buildErrorState(Object error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            const Text(
              'Failed to load schedule',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.invalidate(todayClassesProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Show appointment details (placeholder for future enhancement)
  void _showAppointmentDetails(Appointment appointment) {
    // Future enhancement: show bottom sheet with full details
    debugPrint('Tapped on: ${appointment.subject}');
  }
}
