// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeRange _$TimeRangeFromJson(Map<String, dynamic> json) => _TimeRange(
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
);

Map<String, dynamic> _$TimeRangeToJson(_TimeRange instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

_Group _$GroupFromJson(Map<String, dynamic> json) =>
    _Group(code: json['code'] as String);

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
  'code': instance.code,
};

ClassPlaceOnline _$ClassPlaceOnlineFromJson(Map<String, dynamic> json) =>
    ClassPlaceOnline($type: json['runtimeType'] as String?);

Map<String, dynamic> _$ClassPlaceOnlineToJson(ClassPlaceOnline instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

ClassPlaceOnSite _$ClassPlaceOnSiteFromJson(Map<String, dynamic> json) =>
    ClassPlaceOnSite(
      room: json['room'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ClassPlaceOnSiteToJson(ClassPlaceOnSite instance) =>
    <String, dynamic>{'room': instance.room, 'runtimeType': instance.$type};

_Class _$ClassFromJson(Map<String, dynamic> json) => _Class(
  classId: json['classId'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  kind: $enumDecode(_$ClassKindEnumMap, json['kind']),
  lecturer: json['lecturer'] as String,
  range: TimeRange.fromJson(json['range'] as Map<String, dynamic>),
  place: ClassPlace.fromJson(json['place'] as Map<String, dynamic>),
  groups: (json['groups'] as List<dynamic>)
      .map((e) => Group.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClassToJson(_Class instance) => <String, dynamic>{
  'classId': instance.classId,
  'name': instance.name,
  'code': instance.code,
  'kind': _$ClassKindEnumMap[instance.kind]!,
  'lecturer': instance.lecturer,
  'range': instance.range,
  'place': instance.place,
  'groups': instance.groups,
};

const _$ClassKindEnumMap = {
  ClassKind.lecture: 'lecture',
  ClassKind.seminar: 'seminar',
  ClassKind.diplomaThesis: 'diploma_thesis',
};
