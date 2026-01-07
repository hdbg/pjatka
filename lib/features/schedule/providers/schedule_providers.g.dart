// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the parser singleton instance

@ProviderFor(parser)
final parserProvider = ParserProvider._();

/// Provider for the parser singleton instance

final class ParserProvider
    extends $FunctionalProvider<PjatkParser, PjatkParser, PjatkParser>
    with $Provider<PjatkParser> {
  /// Provider for the parser singleton instance
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

/// Family provider for fetching classes by date

@ProviderFor(classes)
final classesProvider = ClassesFamily._();

/// Family provider for fetching classes by date

final class ClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Class>>,
          List<Class>,
          FutureOr<List<Class>>
        >
    with $FutureModifier<List<Class>>, $FutureProvider<List<Class>> {
  /// Family provider for fetching classes by date
  ClassesProvider._({
    required ClassesFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'classesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$classesHash();

  @override
  String toString() {
    return r'classesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Class>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Class>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return classes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$classesHash() => r'818ed2c38d4eff307896d7dc181d614f2c3edef9';

/// Family provider for fetching classes by date

final class ClassesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Class>>, DateTime> {
  ClassesFamily._()
    : super(
        retry: null,
        name: r'classesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Family provider for fetching classes by date

  ClassesProvider call(DateTime date) =>
      ClassesProvider._(argument: date, from: this);

  @override
  String toString() => r'classesProvider';
}

/// Provider for today's classes

@ProviderFor(todayClasses)
final todayClassesProvider = TodayClassesProvider._();

/// Provider for today's classes

final class TodayClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Class>>,
          List<Class>,
          FutureOr<List<Class>>
        >
    with $FutureModifier<List<Class>>, $FutureProvider<List<Class>> {
  /// Provider for today's classes
  TodayClassesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayClassesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayClassesHash();

  @$internal
  @override
  $FutureProviderElement<List<Class>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Class>> create(Ref ref) {
    return todayClasses(ref);
  }
}

String _$todayClassesHash() => r'99633cd08c30d1c0263e66ee9a0e063b60e45818';
