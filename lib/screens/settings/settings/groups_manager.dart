import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pjatka/features/settings/provider.dart';
import 'package:pjatka/screens/settings/screen.dart';
import 'package:pjatka/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_manager.g.dart';

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

    return Scaffold(
      body: Column(children: [const GroupsList(), NewGroupField()]),
      floatingActionButton: DeletionFab(),
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
      title: const Text('Delete selected groups?'),
      content: Text('This will remove $count group(s).'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (result == true && ref.context.mounted) {
    ref.read(groupSelectionProvider.notifier).deleteSelected();
  }
}

class DeletionFab extends ConsumerWidget {
  const DeletionFab({super.key});

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
        child: FloatingActionButton(
          onPressed: selectedGroups.isNotEmpty
              ? () => showDeleteDialog(ref, context, selectedGroups)
              : null,
          tooltip: 'Delete selected groups',
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}

class NewGroupField extends HookConsumerWidget {
  const NewGroupField({super.key});

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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Group name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => handleAddGroup(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.add), onPressed: handleAddGroup),
        ],
      ),
    );
  }
}

class GroupsList extends ConsumerWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final groups = settings.groups;
    return Expanded(
      child: groups.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No groups yet. Add one below!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          : ListView.builder(
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
    final isSelected = ref.watch(
      groupSelectionProvider.select((state) => state.contains(group)),
    );

    return CheckboxListTile(
      key: ValueKey(group),
      title: Text(group),
      value: isSelected,
      onChanged: (checked) {
        talker.debug(
          '${checked == true ? "Selected" : "Deselected"} group: $group',
        );
        ref.read(groupSelectionProvider.notifier).toggle(group);
      },
    );
  }
}

final groupSetting = Setting(
  title: 'Groups',
  icon: Icons.group,
  description: 'Manage your groups',
  builder: (context) => const GroupsManager(),
);
