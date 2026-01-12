// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

_ScheduledClass _$ScheduledClassFromJson(Map<String, dynamic> json) =>
    _ScheduledClass(
      classId: json['classId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      kind: $enumDecode(_$ClassKindEnumMap, json['kind']),
      lecturer: json['lecturer'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      place: ClassPlace.fromJson(json['place'] as Map<String, dynamic>),
      groups: (json['groups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ScheduledClassToJson(_ScheduledClass instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'name': instance.name,
      'code': instance.code,
      'kind': _$ClassKindEnumMap[instance.kind]!,
      'lecturer': instance.lecturer,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'place': instance.place,
      'groups': instance.groups,
    };

const _$ClassKindEnumMap = {
  ClassKind.lecture: 'lecture',
  ClassKind.seminar: 'seminar',
  ClassKind.diplomaThesis: 'diploma_thesis',
};
