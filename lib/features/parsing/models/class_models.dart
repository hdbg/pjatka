import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_models.freezed.dart';
part 'class_models.g.dart';

/// Enum representing the type of class
enum ClassKind {
  @JsonValue('lecture')
  lecture,
  @JsonValue('seminar')
  seminar,
  @JsonValue('diploma_thesis')
  diplomaThesis;

  /// Parse a ClassKind from a string value
  static ClassKind fromString(String value) {
    return switch (value) {
      'lecture' => ClassKind.lecture,
      'seminar' => ClassKind.seminar,
      'diploma_thesis' => ClassKind.diplomaThesis,
      _ => throw ArgumentError('Unknown ClassKind: $value'),
    };
  }

  /// Get the string value of this ClassKind
  String get value => switch (this) {
        ClassKind.lecture => 'lecture',
        ClassKind.seminar => 'seminar',
        ClassKind.diplomaThesis => 'diploma_thesis',
      };
}

/// Time range with start and end DateTime
@freezed
abstract class TimeRange with _$TimeRange {
  const factory TimeRange({
    required DateTime start,
    required DateTime end,
  }) = _TimeRange;

  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);
}

/// Study mode enum
enum StudyMode {
  @JsonValue('online')
  online,
  @JsonValue('on_site')
  onSite,
  @JsonValue('part_time')
  partTime;
}

/// Language enum
enum Language {
  @JsonValue('english')
  english,
  @JsonValue('polish')
  polish;
}

/// Group representation
@freezed
abstract class Group with _$Group {
  const factory Group({
    required String code,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}

/// Class place - either online or on-site with room
@freezed
abstract class ClassPlace with _$ClassPlace {
  const factory ClassPlace.online() = ClassPlaceOnline;
  const factory ClassPlace.onSite({required String room}) = ClassPlaceOnSite;

  factory ClassPlace.fromJson(Map<String, dynamic> json) =>
      _$ClassPlaceFromJson(json);
}

/// Main class representation
@freezed
abstract class Class with _$Class {
  const factory Class({
    required String classId,
    required String name,
    required String code,
    required ClassKind kind,
    required String lecturer,
    required TimeRange range,
    required ClassPlace place,
    required List<Group> groups,
  }) = _Class;

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
}
