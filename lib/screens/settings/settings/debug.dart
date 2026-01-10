import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:pjatka/features/database/database.dart';
import 'package:pjatka/screens/groups_retriever.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/utils.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _DebugHeader(),
          const SizedBox(height: 24),
          const _DebugActionCards(),
          const SizedBox(height: 24),
          const _DebugWarningNotice(),
        ],
      ),
    );
  }
}

class _DebugHeader extends StatelessWidget {
  const _DebugHeader();

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
            Icon(Icons.developer_mode, size: 48, color: colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              'Developer Tools',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Diagnostic & Recovery tools',
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

class _DebugActionCards extends StatelessWidget {
  const _DebugActionCards();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        _DebugCard(
          icon: Icons.article_outlined,
          title: 'Application Logs',
          subtitle: 'View detailed logs and debugging information',
          color: colorScheme.tertiaryContainer,
          iconColor: colorScheme.tertiary,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TalkerScreen(talker: talker),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _DebugCard(
          icon: Icons.login_outlined,
          title: 'Trigger Group Retriever',
          subtitle: 'Invokes gakko login to retrieve your study groups',
          color: Colors.purple.shade300,
          iconColor: colorScheme.primary,
          isDangerous: true,
          onTap: () => showGroupsRetriever(context),
        ),
        const SizedBox(height: 12),
        _DebugCard(
          icon: Icons.storage_outlined,
          title: 'View Database',
          subtitle: 'View all cached data and database contents',
          color: colorScheme.primaryContainer,
          iconColor: colorScheme.primary,
          isDangerous: true,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DriftDbViewer(db)),
          ),
        ),
        const SizedBox(height: 12),
        _DebugCard(
          icon: Icons.storage_outlined,
          title: 'Clear Database',
          subtitle: 'Remove all cached data and reset the database',
          color: colorScheme.errorContainer,
          iconColor: colorScheme.error,
          isDangerous: true,
          onTap: () => _showClearDatabaseDialog(context),
        ),
      ],
    );
  }

  Future<void> _showClearDatabaseDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text('Clear Database?'),
        content: const Text(
          'This will permanently delete all cached data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      talker.debug('Clearing database');
      await db.transaction(() async {
        await db.customStatement('PRAGMA foreign_keys = OFF;');
        for (final table in db.allTables) {
          await db.delete(table).go();
        }
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database cleared successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

class _DebugWarningNotice extends StatelessWidget {
  const _DebugWarningNotice();

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
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'These tools are for development purposes only',
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

class _DebugCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final bool isDangerous;
  final VoidCallback onTap;

  const _DebugCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconColor,
    this.isDangerous = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: _DebugCardContent(
          color: color,
          iconColor: iconColor,
          icon: icon,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }
}

class _DebugCardContent extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;

  const _DebugCardContent({
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.1)],
        ),
      ),
      child: Row(
        children: [
          _DebugCardIcon(color: iconColor, icon: icon),
          const SizedBox(width: 16),
          _DebugCardText(title: title, subtitle: subtitle),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}

class _DebugCardIcon extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _DebugCardIcon({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 28, color: color),
    );
  }
}

class _DebugCardText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DebugCardText({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

final debugSetting = Setting(
  title: 'Debug',
  icon: Icons.bug_report,
  description: 'Debugging options and information',
  builder: (context) => const Debug(),
);
