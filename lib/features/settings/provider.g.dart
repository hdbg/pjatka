// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wrapper _$WrapperFromJson(Map<String, dynamic> json) => Wrapper(
  value: json['value'] as Map<String, dynamic>,
  deletionDate: json['deletionDate'] == null
      ? null
      : DateTime.parse(json['deletionDate'] as String),
);

Map<String, dynamic> _$WrapperToJson(Wrapper instance) => <String, dynamic>{
  'value': instance.value,
  'deletionDate': instance.deletionDate?.toIso8601String(),
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsStorage)
final settingsStorageProvider = SettingsStorageProvider._();

final class SettingsStorageProvider
    extends $FunctionalProvider<PrefStorage, PrefStorage, PrefStorage>
    with $Provider<PrefStorage> {
  SettingsStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsStorageHash();

  @$internal
  @override
  $ProviderElement<PrefStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrefStorage create(Ref ref) {
    return settingsStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrefStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrefStorage>(value),
    );
  }
}

String _$settingsStorageHash() => r'9408d702f57d97a75f33177cecd8f31f1164834b';

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider
    extends $NotifierProvider<Settings, SettingsState> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsState>(value),
    );
  }
}

String _$settingsHash() => r'4329b5cace10e218ea02733c15b3fb1976096eaf';

abstract class _$Settings extends $Notifier<SettingsState> {
  SettingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SettingsState, SettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SettingsState, SettingsState>,
              SettingsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
