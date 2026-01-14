// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bestAvailableParser)
final bestAvailableParserProvider = BestAvailableParserProvider._();

final class BestAvailableParserProvider
    extends $FunctionalProvider<AsyncValue<Parser>, Parser, FutureOr<Parser>>
    with $FutureModifier<Parser>, $FutureProvider<Parser> {
  BestAvailableParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bestAvailableParserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bestAvailableParserHash();

  @$internal
  @override
  $FutureProviderElement<Parser> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Parser> create(Ref ref) {
    return bestAvailableParser(ref);
  }
}

String _$bestAvailableParserHash() =>
    r'8995b3b82a92157170e5ae87c0707ea8c3895b32';

@ProviderFor(classesReconciler)
final classesReconcilerProvider = ClassesReconcilerProvider._();

final class ClassesReconcilerProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  ClassesReconcilerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classesReconcilerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classesReconcilerHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return classesReconciler(ref);
  }
}

String _$classesReconcilerHash() => r'161961b1da1ad0fc5ba23342ced0b2cd460588c9';
