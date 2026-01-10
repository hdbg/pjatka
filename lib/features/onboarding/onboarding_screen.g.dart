// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingSetup)
final onboardingSetupProvider = OnboardingSetupProvider._();

final class OnboardingSetupProvider
    extends $AsyncNotifierProvider<OnboardingSetup, bool> {
  OnboardingSetupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingSetupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingSetupHash();

  @$internal
  @override
  OnboardingSetup create() => OnboardingSetup();
}

String _$onboardingSetupHash() => r'ae31ad9985242ccb48eb3dd99ad2df96155fda52';

abstract class _$OnboardingSetup extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
