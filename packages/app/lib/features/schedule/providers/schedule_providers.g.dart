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
    extends $FunctionalProvider<AsyncValue<Parser?>, Parser?, FutureOr<Parser?>>
    with $FutureModifier<Parser?>, $FutureProvider<Parser?> {
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
  $FutureProviderElement<Parser?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Parser?> create(Ref ref) {
    return bestAvailableParser(ref);
  }
}

String _$bestAvailableParserHash() =>
    r'79f83a0cd6b8a972210a3ed3fbd8312016ae997b';

@ProviderFor(ClassesReconciler)
final classesReconcilerProvider = ClassesReconcilerProvider._();

final class ClassesReconcilerProvider
    extends $AsyncNotifierProvider<ClassesReconciler, ReconcileState> {
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
  ClassesReconciler create() => ClassesReconciler();
}

String _$classesReconcilerHash() => r'32341626ef4c3485c5d78f9ded0a5cae96864916';

abstract class _$ClassesReconciler extends $AsyncNotifier<ReconcileState> {
  FutureOr<ReconcileState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ReconcileState>, ReconcileState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReconcileState>, ReconcileState>,
              AsyncValue<ReconcileState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
