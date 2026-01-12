import 'package:freezed_annotation/freezed_annotation.dart';

part 'parse_exceptions.freezed.dart';

@freezed
sealed class ParseException with _$ParseException implements Exception {
  const factory ParseException.http({
    String? message,
    StackTrace? stackTrace,
  }) = HttpException;

  const factory ParseException.parsingFailed({
    String? message,
    StackTrace? stackTrace,
  }) = ParsingFailedException;

  const factory ParseException.bodyAbruptied({
    String? message,
    StackTrace? stackTrace,
  }) = BodyAbruptedException;
}
