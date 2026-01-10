import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pjatka/features/onboarding/onboarding_pages.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/groups_retriever.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';
import 'package:pjatka/utils.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  bool _setupInProgress = false;

  void _handleManualSetup() async {
    setState(() => _setupInProgress = true);

    // Navigate to groups manager for manual entry
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GroupsManager(),
      ),
    );

    setState(() => _setupInProgress = false);

    // Check if user added any groups
    final groups = ref.read(settingsProvider).groups;
    if (groups.isNotEmpty) {
      _completeOnboarding();
    }
  }

  void _handleAutomaticSetup() async {
    setState(() => _setupInProgress = true);

    try {
      await showGroupsRetriever(context);

      // Check if groups were successfully retrieved
      final groups = ref.read(settingsProvider).groups;
      if (groups.isNotEmpty) {
        _completeOnboarding();
      } else {
        // Show error or fallback to manual
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('No groups found. Please try manual setup.'),
              action: SnackBarAction(
                label: 'Manual',
                onPressed: _handleManualSetup,
              ),
            ),
          );
        }
      }
    } catch (error) {
      talker.handle(error, null, 'Error during automatic group retrieval');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to retrieve groups. Try manual setup.'),
            action: SnackBarAction(
              label: 'Manual',
              onPressed: _handleManualSetup,
            ),
          ),
        );
      }
    } finally {
      setState(() => _setupInProgress = false);
    }
  }

  void _completeOnboarding() {
    ref.read(settingsProvider.notifier).setHasCompletedOnboarding(true);
    // Navigation will happen automatically via main.dart watching the state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IntroductionScreen(
            key: _introKey,
            pages: OnboardingPages.getPages(
              onManualSetup: _handleManualSetup,
              onAutomaticSetup: _handleAutomaticSetup,
            ),
            onDone: _completeOnboarding,
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
          if (_setupInProgress)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
