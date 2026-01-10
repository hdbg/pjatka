// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      groups:
          (json['groups'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
      minDateDaysOffset: (json['minDateDaysOffset'] as num?)?.toInt() ?? 7,
      maxDateDaysOffset: (json['maxDateDaysOffset'] as num?)?.toInt() ?? 30,
      cacheTTLHours: (json['cacheTTLHours'] as num?)?.toInt() ?? 24,
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'groups': instance.groups.toList(),
      'minDateDaysOffset': instance.minDateDaysOffset,
      'maxDateDaysOffset': instance.maxDateDaysOffset,
      'cacheTTLHours': instance.cacheTTLHours,
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
    };
