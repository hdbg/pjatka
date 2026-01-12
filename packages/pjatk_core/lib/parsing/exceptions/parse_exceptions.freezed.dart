// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parse_exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParseException {

 String? get message; StackTrace? get stackTrace;
/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseExceptionCopyWith<ParseException> get copyWith => _$ParseExceptionCopyWithImpl<ParseException>(this as ParseException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseException&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,stackTrace);

@override
String toString() {
  return 'ParseException(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ParseExceptionCopyWith<$Res>  {
  factory $ParseExceptionCopyWith(ParseException value, $Res Function(ParseException) _then) = _$ParseExceptionCopyWithImpl;
@useResult
$Res call({
 String? message, StackTrace? stackTrace
});




}
/// @nodoc
class _$ParseExceptionCopyWithImpl<$Res>
    implements $ParseExceptionCopyWith<$Res> {
  _$ParseExceptionCopyWithImpl(this._self, this._then);

  final ParseException _self;
  final $Res Function(ParseException) _then;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParseException].
extension ParseExceptionPatterns on ParseException {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HttpException value)?  http,TResult Function( ParsingFailedException value)?  parsingFailed,TResult Function( BodyAbruptedException value)?  bodyAbruptied,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HttpException() when http != null:
return http(_that);case ParsingFailedException() when parsingFailed != null:
return parsingFailed(_that);case BodyAbruptedException() when bodyAbruptied != null:
return bodyAbruptied(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HttpException value)  http,required TResult Function( ParsingFailedException value)  parsingFailed,required TResult Function( BodyAbruptedException value)  bodyAbruptied,}){
final _that = this;
switch (_that) {
case HttpException():
return http(_that);case ParsingFailedException():
return parsingFailed(_that);case BodyAbruptedException():
return bodyAbruptied(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HttpException value)?  http,TResult? Function( ParsingFailedException value)?  parsingFailed,TResult? Function( BodyAbruptedException value)?  bodyAbruptied,}){
final _that = this;
switch (_that) {
case HttpException() when http != null:
return http(_that);case ParsingFailedException() when parsingFailed != null:
return parsingFailed(_that);case BodyAbruptedException() when bodyAbruptied != null:
return bodyAbruptied(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message,  StackTrace? stackTrace)?  http,TResult Function( String? message,  StackTrace? stackTrace)?  parsingFailed,TResult Function( String? message,  StackTrace? stackTrace)?  bodyAbruptied,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HttpException() when http != null:
return http(_that.message,_that.stackTrace);case ParsingFailedException() when parsingFailed != null:
return parsingFailed(_that.message,_that.stackTrace);case BodyAbruptedException() when bodyAbruptied != null:
return bodyAbruptied(_that.message,_that.stackTrace);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message,  StackTrace? stackTrace)  http,required TResult Function( String? message,  StackTrace? stackTrace)  parsingFailed,required TResult Function( String? message,  StackTrace? stackTrace)  bodyAbruptied,}) {final _that = this;
switch (_that) {
case HttpException():
return http(_that.message,_that.stackTrace);case ParsingFailedException():
return parsingFailed(_that.message,_that.stackTrace);case BodyAbruptedException():
return bodyAbruptied(_that.message,_that.stackTrace);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message,  StackTrace? stackTrace)?  http,TResult? Function( String? message,  StackTrace? stackTrace)?  parsingFailed,TResult? Function( String? message,  StackTrace? stackTrace)?  bodyAbruptied,}) {final _that = this;
switch (_that) {
case HttpException() when http != null:
return http(_that.message,_that.stackTrace);case ParsingFailedException() when parsingFailed != null:
return parsingFailed(_that.message,_that.stackTrace);case BodyAbruptedException() when bodyAbruptied != null:
return bodyAbruptied(_that.message,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class HttpException implements ParseException {
  const HttpException({this.message, this.stackTrace});
  

@override final  String? message;
@override final  StackTrace? stackTrace;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HttpExceptionCopyWith<HttpException> get copyWith => _$HttpExceptionCopyWithImpl<HttpException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HttpException&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,stackTrace);

@override
String toString() {
  return 'ParseException.http(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $HttpExceptionCopyWith<$Res> implements $ParseExceptionCopyWith<$Res> {
  factory $HttpExceptionCopyWith(HttpException value, $Res Function(HttpException) _then) = _$HttpExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message, StackTrace? stackTrace
});




}
/// @nodoc
class _$HttpExceptionCopyWithImpl<$Res>
    implements $HttpExceptionCopyWith<$Res> {
  _$HttpExceptionCopyWithImpl(this._self, this._then);

  final HttpException _self;
  final $Res Function(HttpException) _then;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? stackTrace = freezed,}) {
  return _then(HttpException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class ParsingFailedException implements ParseException {
  const ParsingFailedException({this.message, this.stackTrace});
  

@override final  String? message;
@override final  StackTrace? stackTrace;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsingFailedExceptionCopyWith<ParsingFailedException> get copyWith => _$ParsingFailedExceptionCopyWithImpl<ParsingFailedException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsingFailedException&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,stackTrace);

@override
String toString() {
  return 'ParseException.parsingFailed(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ParsingFailedExceptionCopyWith<$Res> implements $ParseExceptionCopyWith<$Res> {
  factory $ParsingFailedExceptionCopyWith(ParsingFailedException value, $Res Function(ParsingFailedException) _then) = _$ParsingFailedExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message, StackTrace? stackTrace
});




}
/// @nodoc
class _$ParsingFailedExceptionCopyWithImpl<$Res>
    implements $ParsingFailedExceptionCopyWith<$Res> {
  _$ParsingFailedExceptionCopyWithImpl(this._self, this._then);

  final ParsingFailedException _self;
  final $Res Function(ParsingFailedException) _then;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? stackTrace = freezed,}) {
  return _then(ParsingFailedException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class BodyAbruptedException implements ParseException {
  const BodyAbruptedException({this.message, this.stackTrace});
  

@override final  String? message;
@override final  StackTrace? stackTrace;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyAbruptedExceptionCopyWith<BodyAbruptedException> get copyWith => _$BodyAbruptedExceptionCopyWithImpl<BodyAbruptedException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyAbruptedException&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,message,stackTrace);

@override
String toString() {
  return 'ParseException.bodyAbruptied(message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $BodyAbruptedExceptionCopyWith<$Res> implements $ParseExceptionCopyWith<$Res> {
  factory $BodyAbruptedExceptionCopyWith(BodyAbruptedException value, $Res Function(BodyAbruptedException) _then) = _$BodyAbruptedExceptionCopyWithImpl;
@override @useResult
$Res call({
 String? message, StackTrace? stackTrace
});




}
/// @nodoc
class _$BodyAbruptedExceptionCopyWithImpl<$Res>
    implements $BodyAbruptedExceptionCopyWith<$Res> {
  _$BodyAbruptedExceptionCopyWithImpl(this._self, this._then);

  final BodyAbruptedException _self;
  final $Res Function(BodyAbruptedException) _then;

/// Create a copy of ParseException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? stackTrace = freezed,}) {
  return _then(BodyAbruptedException(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
