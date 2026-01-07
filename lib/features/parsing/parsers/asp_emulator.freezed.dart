// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asp_emulator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestKind {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestKind);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestKind()';
}


}

/// @nodoc
class $RequestKindCopyWith<$Res>  {
$RequestKindCopyWith(RequestKind _, $Res Function(RequestKind) __);
}


/// Adds pattern-matching-related methods to [RequestKind].
extension RequestKindPatterns on RequestKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialRequest value)?  initial,TResult Function( EventRequest value)?  event,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialRequest() when initial != null:
return initial(_that);case EventRequest() when event != null:
return event(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialRequest value)  initial,required TResult Function( EventRequest value)  event,}){
final _that = this;
switch (_that) {
case InitialRequest():
return initial(_that);case EventRequest():
return event(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialRequest value)?  initial,TResult? Function( EventRequest value)?  event,}){
final _that = this;
switch (_that) {
case InitialRequest() when initial != null:
return initial(_that);case EventRequest() when event != null:
return event(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String target,  String? argument)?  event,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialRequest() when initial != null:
return initial();case EventRequest() when event != null:
return event(_that.target,_that.argument);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String target,  String? argument)  event,}) {final _that = this;
switch (_that) {
case InitialRequest():
return initial();case EventRequest():
return event(_that.target,_that.argument);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String target,  String? argument)?  event,}) {final _that = this;
switch (_that) {
case InitialRequest() when initial != null:
return initial();case EventRequest() when event != null:
return event(_that.target,_that.argument);case _:
  return null;

}
}

}

/// @nodoc


class InitialRequest implements RequestKind {
  const InitialRequest();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialRequest);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestKind.initial()';
}


}




/// @nodoc


class EventRequest implements RequestKind {
  const EventRequest({required this.target, this.argument});
  

 final  String target;
 final  String? argument;

/// Create a copy of RequestKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRequestCopyWith<EventRequest> get copyWith => _$EventRequestCopyWithImpl<EventRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRequest&&(identical(other.target, target) || other.target == target)&&(identical(other.argument, argument) || other.argument == argument));
}


@override
int get hashCode => Object.hash(runtimeType,target,argument);

@override
String toString() {
  return 'RequestKind.event(target: $target, argument: $argument)';
}


}

/// @nodoc
abstract mixin class $EventRequestCopyWith<$Res> implements $RequestKindCopyWith<$Res> {
  factory $EventRequestCopyWith(EventRequest value, $Res Function(EventRequest) _then) = _$EventRequestCopyWithImpl;
@useResult
$Res call({
 String target, String? argument
});




}
/// @nodoc
class _$EventRequestCopyWithImpl<$Res>
    implements $EventRequestCopyWith<$Res> {
  _$EventRequestCopyWithImpl(this._self, this._then);

  final EventRequest _self;
  final $Res Function(EventRequest) _then;

/// Create a copy of RequestKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? target = null,Object? argument = freezed,}) {
  return _then(EventRequest(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,argument: freezed == argument ? _self.argument : argument // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AspRequest {

 String get endpoint; RequestKind get kind; bool get isDelta; Map<String, String> get stateOverride;
/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspRequestCopyWith<AspRequest> get copyWith => _$AspRequestCopyWithImpl<AspRequest>(this as AspRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspRequest&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isDelta, isDelta) || other.isDelta == isDelta)&&const DeepCollectionEquality().equals(other.stateOverride, stateOverride));
}


@override
int get hashCode => Object.hash(runtimeType,endpoint,kind,isDelta,const DeepCollectionEquality().hash(stateOverride));

@override
String toString() {
  return 'AspRequest(endpoint: $endpoint, kind: $kind, isDelta: $isDelta, stateOverride: $stateOverride)';
}


}

/// @nodoc
abstract mixin class $AspRequestCopyWith<$Res>  {
  factory $AspRequestCopyWith(AspRequest value, $Res Function(AspRequest) _then) = _$AspRequestCopyWithImpl;
@useResult
$Res call({
 String endpoint, RequestKind kind, bool isDelta, Map<String, String> stateOverride
});


$RequestKindCopyWith<$Res> get kind;

}
/// @nodoc
class _$AspRequestCopyWithImpl<$Res>
    implements $AspRequestCopyWith<$Res> {
  _$AspRequestCopyWithImpl(this._self, this._then);

  final AspRequest _self;
  final $Res Function(AspRequest) _then;

/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? endpoint = null,Object? kind = null,Object? isDelta = null,Object? stateOverride = null,}) {
  return _then(_self.copyWith(
endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RequestKind,isDelta: null == isDelta ? _self.isDelta : isDelta // ignore: cast_nullable_to_non_nullable
as bool,stateOverride: null == stateOverride ? _self.stateOverride : stateOverride // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestKindCopyWith<$Res> get kind {
  
  return $RequestKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}


/// Adds pattern-matching-related methods to [AspRequest].
extension AspRequestPatterns on AspRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspRequest value)  $default,){
final _that = this;
switch (_that) {
case _AspRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AspRequest() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String endpoint,  RequestKind kind,  bool isDelta,  Map<String, String> stateOverride)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AspRequest() when $default != null:
return $default(_that.endpoint,_that.kind,_that.isDelta,_that.stateOverride);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String endpoint,  RequestKind kind,  bool isDelta,  Map<String, String> stateOverride)  $default,) {final _that = this;
switch (_that) {
case _AspRequest():
return $default(_that.endpoint,_that.kind,_that.isDelta,_that.stateOverride);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String endpoint,  RequestKind kind,  bool isDelta,  Map<String, String> stateOverride)?  $default,) {final _that = this;
switch (_that) {
case _AspRequest() when $default != null:
return $default(_that.endpoint,_that.kind,_that.isDelta,_that.stateOverride);case _:
  return null;

}
}

}

/// @nodoc


class _AspRequest implements AspRequest {
  const _AspRequest({this.endpoint = '', required this.kind, this.isDelta = false, final  Map<String, String> stateOverride = const {}}): _stateOverride = stateOverride;
  

@override@JsonKey() final  String endpoint;
@override final  RequestKind kind;
@override@JsonKey() final  bool isDelta;
 final  Map<String, String> _stateOverride;
@override@JsonKey() Map<String, String> get stateOverride {
  if (_stateOverride is EqualUnmodifiableMapView) return _stateOverride;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stateOverride);
}


/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspRequestCopyWith<_AspRequest> get copyWith => __$AspRequestCopyWithImpl<_AspRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspRequest&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isDelta, isDelta) || other.isDelta == isDelta)&&const DeepCollectionEquality().equals(other._stateOverride, _stateOverride));
}


@override
int get hashCode => Object.hash(runtimeType,endpoint,kind,isDelta,const DeepCollectionEquality().hash(_stateOverride));

@override
String toString() {
  return 'AspRequest(endpoint: $endpoint, kind: $kind, isDelta: $isDelta, stateOverride: $stateOverride)';
}


}

/// @nodoc
abstract mixin class _$AspRequestCopyWith<$Res> implements $AspRequestCopyWith<$Res> {
  factory _$AspRequestCopyWith(_AspRequest value, $Res Function(_AspRequest) _then) = __$AspRequestCopyWithImpl;
@override @useResult
$Res call({
 String endpoint, RequestKind kind, bool isDelta, Map<String, String> stateOverride
});


@override $RequestKindCopyWith<$Res> get kind;

}
/// @nodoc
class __$AspRequestCopyWithImpl<$Res>
    implements _$AspRequestCopyWith<$Res> {
  __$AspRequestCopyWithImpl(this._self, this._then);

  final _AspRequest _self;
  final $Res Function(_AspRequest) _then;

/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? endpoint = null,Object? kind = null,Object? isDelta = null,Object? stateOverride = null,}) {
  return _then(_AspRequest(
endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RequestKind,isDelta: null == isDelta ? _self.isDelta : isDelta // ignore: cast_nullable_to_non_nullable
as bool,stateOverride: null == stateOverride ? _self._stateOverride : stateOverride // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of AspRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestKindCopyWith<$Res> get kind {
  
  return $RequestKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}

/// @nodoc
mixin _$AspResponse {

 int get statusCode; String? get body;
/// Create a copy of AspResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AspResponseCopyWith<AspResponse> get copyWith => _$AspResponseCopyWithImpl<AspResponse>(this as AspResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AspResponse&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,body);

@override
String toString() {
  return 'AspResponse(statusCode: $statusCode, body: $body)';
}


}

/// @nodoc
abstract mixin class $AspResponseCopyWith<$Res>  {
  factory $AspResponseCopyWith(AspResponse value, $Res Function(AspResponse) _then) = _$AspResponseCopyWithImpl;
@useResult
$Res call({
 int statusCode, String? body
});




}
/// @nodoc
class _$AspResponseCopyWithImpl<$Res>
    implements $AspResponseCopyWith<$Res> {
  _$AspResponseCopyWithImpl(this._self, this._then);

  final AspResponse _self;
  final $Res Function(AspResponse) _then;

/// Create a copy of AspResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = null,Object? body = freezed,}) {
  return _then(_self.copyWith(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AspResponse].
extension AspResponsePatterns on AspResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AspResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AspResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AspResponse value)  $default,){
final _that = this;
switch (_that) {
case _AspResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AspResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AspResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int statusCode,  String? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AspResponse() when $default != null:
return $default(_that.statusCode,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int statusCode,  String? body)  $default,) {final _that = this;
switch (_that) {
case _AspResponse():
return $default(_that.statusCode,_that.body);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int statusCode,  String? body)?  $default,) {final _that = this;
switch (_that) {
case _AspResponse() when $default != null:
return $default(_that.statusCode,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _AspResponse implements AspResponse {
  const _AspResponse({required this.statusCode, this.body});
  

@override final  int statusCode;
@override final  String? body;

/// Create a copy of AspResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AspResponseCopyWith<_AspResponse> get copyWith => __$AspResponseCopyWithImpl<_AspResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AspResponse&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,body);

@override
String toString() {
  return 'AspResponse(statusCode: $statusCode, body: $body)';
}


}

/// @nodoc
abstract mixin class _$AspResponseCopyWith<$Res> implements $AspResponseCopyWith<$Res> {
  factory _$AspResponseCopyWith(_AspResponse value, $Res Function(_AspResponse) _then) = __$AspResponseCopyWithImpl;
@override @useResult
$Res call({
 int statusCode, String? body
});




}
/// @nodoc
class __$AspResponseCopyWithImpl<$Res>
    implements _$AspResponseCopyWith<$Res> {
  __$AspResponseCopyWithImpl(this._self, this._then);

  final _AspResponse _self;
  final $Res Function(_AspResponse) _then;

/// Create a copy of AspResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = null,Object? body = freezed,}) {
  return _then(_AspResponse(
statusCode: null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
