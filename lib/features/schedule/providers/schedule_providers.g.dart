// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parser)
final parserProvider = ParserProvider._();

final class ParserProvider
    extends $FunctionalProvider<PjatkParser, PjatkParser, PjatkParser>
    with $Provider<PjatkParser> {
  ParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parserHash();

  @$internal
  @override
  $ProviderElement<PjatkParser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PjatkParser create(Ref ref) {
    return parser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PjatkParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PjatkParser>(value),
    );
  }
}

String _$parserHash() => r'2101fa7a48eb73802b71ba99511954eb442fddf5';

@ProviderFor(globalLoader)
final globalLoaderProvider = GlobalLoaderProvider._();

final class GlobalLoaderProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  GlobalLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalLoaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalLoaderHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return globalLoader(ref);
  }
}

String _$globalLoaderHash() => r'766193bbeb5f83f67eaf39de8a5635139cf42c27';
