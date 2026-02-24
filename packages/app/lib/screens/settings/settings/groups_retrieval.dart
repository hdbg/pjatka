import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/groups_retriever/group_setup_widget.dart';
import 'package:pjatka/screens/groups_retriever/groups_retriever.dart';
import 'package:pjatka/screens/groups_retriever/ics_resolver/ical_resolver.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';
import 'package:pjatka/utils.dart';

class GroupsRetrieval extends ConsumerWidget {
  const GroupsRetrieval({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GroupsRetrievalHeader(),
          const SizedBox(height: 24),
          GroupSetupWidget(
            onIcalSetup: () => _handleIcalSetup(context, ref),
            onAutomaticSetup: () => _handleAutomaticSetup(context, ref),
            onManualSetup: () => _handleManualSetup(context),
          ),
        ],
      ),
    );
  }

  Future<void> _handleIcalSetup(BuildContext context, WidgetRef ref) async {
    try {
      final groups = await showIcalResolver(context);
      ref.read(settingsProvider.notifier).replaceGroups(groups);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Groups updated successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e, st) {
      talker.handle(e, st, 'Error during iCal setup');
    }
  }

  Future<void> _handleAutomaticSetup(BuildContext context, WidgetRef ref) async {
    try {
      final groups = await showGroupsRetriever(context);
      ref.read(settingsProvider.notifier).replaceGroups(groups);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Groups updated successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e, st) {
      talker.handle(e, st, 'Error during automatic setup');
    }
  }

  void _handleManualSetup(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Manage Groups')),
          body: const GroupsManager(),
        ),
      ),
    );
  }
}

class _GroupsRetrievalHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.manage_search, size: 48, color: colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              'Groups Retrieval',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Re-run a retrieval method to update your study groups',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

final groupsRetrievalSetting = Setting(
  title: 'Groups Retrieval',
  icon: Icons.manage_search,
  description: 'Re-run iCal, automatic, or manual group setup',
  builder: (context) => const GroupsRetrieval(),
);
