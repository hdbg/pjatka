// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Selected)
final selectedProvider = SelectedProvider._();

final class SelectedProvider extends $NotifierProvider<Selected, Setting?> {
  SelectedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHash();

  @$internal
  @override
  Selected create() => Selected();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Setting? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Setting?>(value),
    );
  }
}

String _$selectedHash() => r'cbaa1a61e7df3674dd79b6a593192f36243c6b63';

abstract class _$Selected extends $Notifier<Setting?> {
  Setting? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Setting?, Setting?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Setting?, Setting?>,
              Setting?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
