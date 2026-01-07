import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

enum StudyMode {
  @JsonValue('online')
  online,
  @JsonValue('on_site')
  onSite,
  @JsonValue('part_time')
  partTime,
}

enum Language {
  @JsonValue('english')
  english,
  @JsonValue('polish')
  polish,
}

enum ClassKind {
  @JsonValue('lecture')
  lecture,
  @JsonValue('seminar')
  seminar,
  @JsonValue('diploma_thesis')
  diplomaThesis;

  static ClassKind fromString(String value) {
    return switch (value) {
      'lecture' => ClassKind.lecture,
      'seminar' => ClassKind.seminar,
      'diploma_thesis' => ClassKind.diplomaThesis,
      _ => throw ArgumentError('Unknown ClassKind: $value'),
    };
  }

  String get value => switch (this) {
    ClassKind.lecture => 'lecture',
    ClassKind.seminar => 'seminar',
    ClassKind.diplomaThesis => 'diploma_thesis',
  };
}

@freezed
abstract class ClassPlace with _$ClassPlace {
  const factory ClassPlace.online() = ClassPlaceOnline;
  const factory ClassPlace.onSite({required String room}) = ClassPlaceOnSite;

  // factory ClassPlace.fromJson(Map<String, dynamic> json) =>
  //     _$ClassPlaceFromJson(json);
}