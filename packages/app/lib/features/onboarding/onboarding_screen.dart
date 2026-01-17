import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pjatka/features/onboarding/onboarding_pages.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/groups_retriever/groups_retriever.dart';
import 'package:pjatka/screens/groups_retriever/ical_inductor/ical_inductor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_screen.g.dart';

@Riverpod(keepAlive: true)
class OnboardingSetup extends _$OnboardingSetup {
  @override
  Future<bool> build() async {
    return false;
  }

  void handleManualSetup(BuildContext context) async {
    state = AsyncData(true);
  }

  Future<void> handleIcalSetup(BuildContext context) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await showIcalInductor(context);
      return true;
    });
  }

  Future<void> handleAutomaticSetup(BuildContext context) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await showGroupsRetriever(context);

      final groups = ref.read(settingsProvider).groups;
      if (!groups.isNotEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('No groups found. Please try manual setup.'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () => handleManualSetup(context),
              ),
            ),
          );
        }
      }

      return true;
    });
  }
}

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(onboardingSetupProvider, (previous, next) {
      next.whenData((groupsAdded) {
        if (groupsAdded) {
          ref.read(onboardingProvider.notifier).completeOnboarding();
        }
      });
    });

    return Scaffold(
      body: IntroductionScreen(
        pages: OnboardingPages.getPages(
          onManualSetup: () => ref
              .read(onboardingSetupProvider.notifier)
              .handleManualSetup(context),
          onAutomaticSetup: () => ref
              .read(onboardingSetupProvider.notifier)
              .handleAutomaticSetup(context),
          onIcalSetup: () => ref
              .read(onboardingSetupProvider.notifier)
              .handleIcalSetup(context),
        ),
        onDone: () =>
            ref.read(onboardingProvider.notifier).completeOnboarding(),
        showNextButton: true,
        showDoneButton: true,
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.primary,
          color: Colors.grey,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
