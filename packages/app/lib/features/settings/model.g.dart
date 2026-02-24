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
      cacheTTLMinutes:
          (json['cacheTTLMinutes'] as num?)?.toInt() ??
          ReconcilerConfig.defaultCacheTTLMinutes,
      soonDaysThreshold:
          (json['soonDaysThreshold'] as num?)?.toInt() ??
          ReconcilerConfig.defaultSoonDaysThreshold,
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'groups': instance.groups.toList(),
      'minDateDaysOffset': instance.minDateDaysOffset,
      'maxDateDaysOffset': instance.maxDateDaysOffset,
      'cacheTTLMinutes': instance.cacheTTLMinutes,
      'soonDaysThreshold': instance.soonDaysThreshold,
    };
