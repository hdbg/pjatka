import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/onboarding/onboarding_screen.dart';
import 'package:pjatka/features/schedule/providers/schedule_providers.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/home.dart';
import 'package:pjatka/screens/general_schedule.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/utils.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'screens/schedule.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: false,
        printResponseHeaders: false,
        printResponseMessage: false,
        printResponseData: false,
        printRequestData: false,
      ),
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCompletedOnboarding = ref.watch(onboardingProvider).value ?? false;

    return Sizer(
      builder: (context, orientation, deviceType) {
        // Start loading classes early
        ref.read(classesReconcilerProvider);

        return MaterialApp(
          title: 'PJATKa',
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightBlue,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: ThemeMode.dark,
          home: SafeArea(
            child: hasCompletedOnboarding
                ? Scaffold(
                    // appBar: AppBar(
                    //   title: FittedBox(
                    //     fit: BoxFit.scaleDown,
                    //     child: Text('PJATK App'),
                    //   ),
                    //   backgroundColor: Colors.blueGrey,
                    //   centerTitle: false,
                    //   toolbarHeight: 7.h,
                    // ),
                    body: HomeRouter(
                      destinations: [
                        scheduleDestination,
                        generalScheduleDestination,
                        settingsDestination,
                      ],
                    ),
                  )
                : const OnboardingScreen(),
          ),
        );
      },
    );
  }
}
