import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default({}) Set<String> groups,

    @Default(7) int minDateDaysOffset,

    @Default(30) int maxDateDaysOffset,

    @Default(24) int cacheTTLHours,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
