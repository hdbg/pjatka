// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$classesReconcilerHash() => r'01fcb81379e0f137e7cdfb7c12514e5bc694c446';
