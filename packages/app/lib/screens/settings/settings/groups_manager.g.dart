// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupSelection)
final groupSelectionProvider = GroupSelectionProvider._();

final class GroupSelectionProvider
    extends $NotifierProvider<GroupSelection, Set<String>> {
  GroupSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupSelectionHash();

  @$internal
  @override
  GroupSelection create() => GroupSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$groupSelectionHash() => r'7b1eba997899e949b1af075d47bf21382fdae1ce';

abstract class _$GroupSelection extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
