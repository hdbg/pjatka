import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/groups_retriever/group_setup_widget.dart';
import 'package:pjatka/screens/groups_retriever/groups_retriever.dart';
import 'package:pjatka/screens/groups_retriever/ics_resolver/ical_resolver.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/screens/settings/settings/groups_manager.dart';
import 'package:pjatka/utils.dart';
import 'package:sizer/sizer.dart';

class GroupsRetrieval extends ConsumerWidget {
  const GroupsRetrieval({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(1.6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GroupsRetrievalHeader(),
          SizedBox(height: 2.4.h),
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
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            Icon(Icons.manage_search, size: 4.8.h, color: colorScheme.primary),
            SizedBox(height: 1.2.h),
            Text(
              'Groups Retrieval',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 0.8.h),
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
