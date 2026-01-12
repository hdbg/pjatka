// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleDao)
final scheduleDaoProvider = ScheduleDaoProvider._();

final class ScheduleDaoProvider
    extends $FunctionalProvider<ScheduleDao, ScheduleDao, ScheduleDao>
    with $Provider<ScheduleDao> {
  ScheduleDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleDaoHash();

  @$internal
  @override
  $ProviderElement<ScheduleDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScheduleDao create(Ref ref) {
    return scheduleDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleDao>(value),
    );
  }
}

String _$scheduleDaoHash() => r'2969e63d7a60118243e167945e113df1fb20abba';
