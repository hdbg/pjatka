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

String _$scheduleDaoHash() => r'10453be8692eedfbae008c6b2fc54735a9e64c74';

@ProviderFor(classes)
final classesProvider = ClassesFamily._();

final class ClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScheduledClass>>,
          List<ScheduledClass>,
          FutureOr<List<ScheduledClass>>
        >
    with
        $FutureModifier<List<ScheduledClass>>,
        $FutureProvider<List<ScheduledClass>> {
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
  $FutureProviderElement<List<ScheduledClass>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScheduledClass>> create(Ref ref) {
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

String _$classesHash() => r'ff480c42a404790a45591c53148a4c3c60086374';

final class ClassesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ScheduledClass>>, DateTime> {
  ClassesFamily._()
    : super(
        retry: null,
        name: r'classesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClassesProvider call(DateTime day) =>
      ClassesProvider._(argument: day, from: this);

  @override
  String toString() => r'classesProvider';
}

@ProviderFor(onlySelectedClasses)
final onlySelectedClassesProvider = OnlySelectedClassesFamily._();

final class OnlySelectedClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScheduledClass>>,
          List<ScheduledClass>,
          FutureOr<List<ScheduledClass>>
        >
    with
        $FutureModifier<List<ScheduledClass>>,
        $FutureProvider<List<ScheduledClass>> {
  OnlySelectedClassesProvider._({
    required OnlySelectedClassesFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'onlySelectedClassesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$onlySelectedClassesHash();

  @override
  String toString() {
    return r'onlySelectedClassesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ScheduledClass>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScheduledClass>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return onlySelectedClasses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OnlySelectedClassesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$onlySelectedClassesHash() =>
    r'f3e6183fc2f152077dab60a26e7a79758f8da5dd';

final class OnlySelectedClassesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ScheduledClass>>, DateTime> {
  OnlySelectedClassesFamily._()
    : super(
        retry: null,
        name: r'onlySelectedClassesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OnlySelectedClassesProvider call(DateTime day) =>
      OnlySelectedClassesProvider._(argument: day, from: this);

  @override
  String toString() => r'onlySelectedClassesProvider';
}

@ProviderFor(Schedule)
final scheduleProvider = ScheduleProvider._();

final class ScheduleProvider
    extends
        $AsyncNotifierProvider<Schedule, Map<DateTime, List<ScheduledClass>>> {
  ScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleHash();

  @$internal
  @override
  Schedule create() => Schedule();
}

String _$scheduleHash() => r'e472f6d1678c1d8c8e4aa377c2c680be5ba20bd9';

abstract class _$Schedule
    extends $AsyncNotifier<Map<DateTime, List<ScheduledClass>>> {
  FutureOr<Map<DateTime, List<ScheduledClass>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<DateTime, List<ScheduledClass>>>,
              Map<DateTime, List<ScheduledClass>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<DateTime, List<ScheduledClass>>>,
                Map<DateTime, List<ScheduledClass>>
              >,
              AsyncValue<Map<DateTime, List<ScheduledClass>>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
