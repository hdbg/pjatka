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

/// Provider for the database instance

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Provider for the database instance

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Provider for the database instance
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'4cd3cbf5ffb31168e5da8b2b9154e07483d00352';

/// Provider for the schedule DAO

@ProviderFor(scheduleDao)
final scheduleDaoProvider = ScheduleDaoProvider._();

/// Provider for the schedule DAO

final class ScheduleDaoProvider
    extends $FunctionalProvider<ScheduleDao, ScheduleDao, ScheduleDao>
    with $Provider<ScheduleDao> {
  /// Provider for the schedule DAO
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

String _$scheduleDaoHash() => r'ff6b9bccaac23817224139505f181c321286bb89';

/// Family provider for fetching classes by date with cache-first strategy

@ProviderFor(classes)
final classesProvider = ClassesFamily._();

/// Family provider for fetching classes by date with cache-first strategy

final class ClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Class>>,
          List<Class>,
          FutureOr<List<Class>>
        >
    with $FutureModifier<List<Class>>, $FutureProvider<List<Class>> {
  /// Family provider for fetching classes by date with cache-first strategy
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

String _$classesHash() => r'a1549b5df5d9d00e2d08e69190047b16ac14a1af';

/// Family provider for fetching classes by date with cache-first strategy

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

  /// Family provider for fetching classes by date with cache-first strategy

  ClassesProvider call(DateTime date) =>
      ClassesProvider._(argument: date, from: this);

  @override
  String toString() => r'classesProvider';
}

/// Provider for today's classes (convenience wrapper)

@ProviderFor(todayClasses)
final todayClassesProvider = TodayClassesProvider._();

/// Provider for today's classes (convenience wrapper)

final class TodayClassesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Class>>,
          List<Class>,
          FutureOr<List<Class>>
        >
    with $FutureModifier<List<Class>>, $FutureProvider<List<Class>> {
  /// Provider for today's classes (convenience wrapper)
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

String _$todayClassesHash() => r'5bd708169b555c29783910875621996c79649ed0';
