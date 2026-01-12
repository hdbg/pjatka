import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_manager.g.dart';

class _GroupsHeader extends StatelessWidget {
  const _GroupsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.groups_2,
                  size: 28,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage Groups',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage which study groups you want to follow',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyGroupsState extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _EmptyGroupsState({
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.group_add,
                size: 64,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Groups Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add first group to show schedule for it',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



@riverpod
class GroupSelection extends _$GroupSelection {
  @override
  Set<String> build() {
    return {};
  }

  void toggle(String group) {
    if (state.contains(group)) {
      state = {...state}..remove(group);
    } else {
      state = {...state, group};
    }
  }

  void clear() {
    state = {};
  }

  bool isSelected(String group) {
    return state.contains(group);
  }

  void deleteSelected() {
    final selectedGroups = state;
    if (selectedGroups.isEmpty) return;

    final settingsNotifier = ref.read(settingsProvider.notifier);
    for (final group in selectedGroups) {
      settingsNotifier.removeGroup(group);
    }

    clear();
  }
}

// Main groups management screen
class GroupsManager extends HookConsumerWidget {
  const GroupsManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    talker.debug(ref.read(  settingsProvider).groups.toString());
    return Scaffold(
      body: Column(
        children: [
          const _GroupsHeader(),
          const _GroupsList(),
          const _NewGroupField(),
        ],
      ),
      floatingActionButton: const _DeletionFab(),
    );
  }
}

Future<void> showDeleteDialog(
  WidgetRef ref,
  BuildContext context,
  Set<String> selectedGroups,
) async {
  final count = selectedGroups.length;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.warning_amber_rounded),
      title: const Text('Delete selected groups?'),
      content: Text(
        'This will permanently remove $count group${count > 1 ? 's' : ''}.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (result == true && ref.context.mounted) {
    ref.read(groupSelectionProvider.notifier).deleteSelected();
  }
}

class _DeletionFab extends ConsumerWidget {
  const _DeletionFab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGroups = ref.watch(groupSelectionProvider);
    
    return AnimatedSlide(
      offset: selectedGroups.isNotEmpty ? Offset.zero : const Offset(0, 2),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: selectedGroups.isNotEmpty ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton.extended(
          onPressed: selectedGroups.isNotEmpty
              ? () => showDeleteDialog(ref, context, selectedGroups)
              : null,
          icon: const Icon(Icons.delete),
          label: Text('Delete (${selectedGroups.length})'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}

class _NewGroupField extends HookConsumerWidget {
  const _NewGroupField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();

    final handleAddGroup = () {
      final groupName = textController.text.trim();
      if (groupName.isEmpty) return;

      ref.read(settingsProvider.notifier).addGroup(groupName);
      textController.clear();
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Group name',
                    hintText: 'Enter group name...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.group_add),
                    suffixIcon: textController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => textController.clear(),
                          )
                        : null,
                  ),
                  onSubmitted: (_) => handleAddGroup(),
                  onChanged: (_) => (context as Element).markNeedsBuild(),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: handleAddGroup,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GroupsList extends ConsumerWidget {
  const _GroupsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final settings = ref.watch(settingsProvider);
    final groups = settings.groups;

    return Expanded(
      child: groups.isEmpty
          ? _EmptyGroupsState(
              theme: theme,
              colorScheme: colorScheme,
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GroupTile(group: groups.elementAt(index));
              },
            ),
    );
  }
}

// Separate GroupTile widget that subscribes to selection provider
class GroupTile extends ConsumerWidget {
  final String group;

  const GroupTile({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = ref.watch(
      groupSelectionProvider.select((state) => state.contains(group)),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        child: CheckboxListTile(
          key: ValueKey(group),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            group,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          secondary: Icon(
            Icons.group,
            color: isSelected ? colorScheme.primary : null,
          ),
          value: isSelected,
          onChanged: (checked) {
            talker.debug(
              '${checked == true ? "Selected" : "Deselected"} group: $group',
            );
            ref.read(groupSelectionProvider.notifier).toggle(group);
          },
        ),
      ),
    );
  }
}

final groupSetting = Setting(
  title: 'Groups',
  icon: Icons.group,
  description: 'Manage your study groups',
  builder: (context) => const GroupsManager(),
);
