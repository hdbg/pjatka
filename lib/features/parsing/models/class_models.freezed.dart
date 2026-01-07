// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeRange {

 DateTime get start; DateTime get end;
/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeRangeCopyWith<TimeRange> get copyWith => _$TimeRangeCopyWithImpl<TimeRange>(this as TimeRange, _$identity);

  /// Serializes this TimeRange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'TimeRange(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $TimeRangeCopyWith<$Res>  {
  factory $TimeRangeCopyWith(TimeRange value, $Res Function(TimeRange) _then) = _$TimeRangeCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class _$TimeRangeCopyWithImpl<$Res>
    implements $TimeRangeCopyWith<$Res> {
  _$TimeRangeCopyWithImpl(this._self, this._then);

  final TimeRange _self;
  final $Res Function(TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeRange].
extension TimeRangePatterns on TimeRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeRange value)  $default,){
final _that = this;
switch (_that) {
case _TimeRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeRange value)?  $default,){
final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime start,  DateTime end)  $default,) {final _that = this;
switch (_that) {
case _TimeRange():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime start,  DateTime end)?  $default,) {final _that = this;
switch (_that) {
case _TimeRange() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeRange implements TimeRange {
  const _TimeRange({required this.start, required this.end});
  factory _TimeRange.fromJson(Map<String, dynamic> json) => _$TimeRangeFromJson(json);

@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeRangeCopyWith<_TimeRange> get copyWith => __$TimeRangeCopyWithImpl<_TimeRange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeRangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'TimeRange(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$TimeRangeCopyWith<$Res> implements $TimeRangeCopyWith<$Res> {
  factory _$TimeRangeCopyWith(_TimeRange value, $Res Function(_TimeRange) _then) = __$TimeRangeCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class __$TimeRangeCopyWithImpl<$Res>
    implements _$TimeRangeCopyWith<$Res> {
  __$TimeRangeCopyWithImpl(this._self, this._then);

  final _TimeRange _self;
  final $Res Function(_TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_TimeRange(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Group {

 String get code;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'Group(code: $code)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Group].
extension GroupPatterns on Group {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Group value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Group value)  $default,){
final _that = this;
switch (_that) {
case _Group():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Group value)?  $default,){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code)  $default,) {final _that = this;
switch (_that) {
case _Group():
return $default(_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code)?  $default,) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Group implements Group {
  const _Group({required this.code});
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override final  String code;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'Group(code: $code)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
 String code
});




}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_Group(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

ClassPlace _$ClassPlaceFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'online':
          return ClassPlaceOnline.fromJson(
            json
          );
                case 'onSite':
          return ClassPlaceOnSite.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'ClassPlace',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ClassPlace {



  /// Serializes this ClassPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlace);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClassPlace()';
}


}

/// @nodoc
class $ClassPlaceCopyWith<$Res>  {
$ClassPlaceCopyWith(ClassPlace _, $Res Function(ClassPlace) __);
}


/// Adds pattern-matching-related methods to [ClassPlace].
extension ClassPlacePatterns on ClassPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClassPlaceOnline value)?  online,TResult Function( ClassPlaceOnSite value)?  onSite,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClassPlaceOnline() when online != null:
return online(_that);case ClassPlaceOnSite() when onSite != null:
return onSite(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClassPlaceOnline value)  online,required TResult Function( ClassPlaceOnSite value)  onSite,}){
final _that = this;
switch (_that) {
case ClassPlaceOnline():
return online(_that);case ClassPlaceOnSite():
return onSite(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClassPlaceOnline value)?  online,TResult? Function( ClassPlaceOnSite value)?  onSite,}){
final _that = this;
switch (_that) {
case ClassPlaceOnline() when online != null:
return online(_that);case ClassPlaceOnSite() when onSite != null:
return onSite(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  online,TResult Function( String room)?  onSite,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClassPlaceOnline() when online != null:
return online();case ClassPlaceOnSite() when onSite != null:
return onSite(_that.room);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  online,required TResult Function( String room)  onSite,}) {final _that = this;
switch (_that) {
case ClassPlaceOnline():
return online();case ClassPlaceOnSite():
return onSite(_that.room);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  online,TResult? Function( String room)?  onSite,}) {final _that = this;
switch (_that) {
case ClassPlaceOnline() when online != null:
return online();case ClassPlaceOnSite() when onSite != null:
return onSite(_that.room);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ClassPlaceOnline implements ClassPlace {
  const ClassPlaceOnline({final  String? $type}): $type = $type ?? 'online';
  factory ClassPlaceOnline.fromJson(Map<String, dynamic> json) => _$ClassPlaceOnlineFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ClassPlaceOnlineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlaceOnline);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClassPlace.online()';
}


}




/// @nodoc
@JsonSerializable()

class ClassPlaceOnSite implements ClassPlace {
  const ClassPlaceOnSite({required this.room, final  String? $type}): $type = $type ?? 'onSite';
  factory ClassPlaceOnSite.fromJson(Map<String, dynamic> json) => _$ClassPlaceOnSiteFromJson(json);

 final  String room;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of ClassPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassPlaceOnSiteCopyWith<ClassPlaceOnSite> get copyWith => _$ClassPlaceOnSiteCopyWithImpl<ClassPlaceOnSite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassPlaceOnSiteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlaceOnSite&&(identical(other.room, room) || other.room == room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,room);

@override
String toString() {
  return 'ClassPlace.onSite(room: $room)';
}


}

/// @nodoc
abstract mixin class $ClassPlaceOnSiteCopyWith<$Res> implements $ClassPlaceCopyWith<$Res> {
  factory $ClassPlaceOnSiteCopyWith(ClassPlaceOnSite value, $Res Function(ClassPlaceOnSite) _then) = _$ClassPlaceOnSiteCopyWithImpl;
@useResult
$Res call({
 String room
});




}
/// @nodoc
class _$ClassPlaceOnSiteCopyWithImpl<$Res>
    implements $ClassPlaceOnSiteCopyWith<$Res> {
  _$ClassPlaceOnSiteCopyWithImpl(this._self, this._then);

  final ClassPlaceOnSite _self;
  final $Res Function(ClassPlaceOnSite) _then;

/// Create a copy of ClassPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? room = null,}) {
  return _then(ClassPlaceOnSite(
room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Class {

 String get classId; String get name; String get code; ClassKind get kind; String get lecturer; TimeRange get range; ClassPlace get place; List<Group> get groups;
/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassCopyWith<Class> get copyWith => _$ClassCopyWithImpl<Class>(this as Class, _$identity);

  /// Serializes this Class to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Class&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.range, range) || other.range == range)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,code,kind,lecturer,range,place,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'Class(classId: $classId, name: $name, code: $code, kind: $kind, lecturer: $lecturer, range: $range, place: $place, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $ClassCopyWith<$Res>  {
  factory $ClassCopyWith(Class value, $Res Function(Class) _then) = _$ClassCopyWithImpl;
@useResult
$Res call({
 String classId, String name, String code, ClassKind kind, String lecturer, TimeRange range, ClassPlace place, List<Group> groups
});


$TimeRangeCopyWith<$Res> get range;$ClassPlaceCopyWith<$Res> get place;

}
/// @nodoc
class _$ClassCopyWithImpl<$Res>
    implements $ClassCopyWith<$Res> {
  _$ClassCopyWithImpl(this._self, this._then);

  final Class _self;
  final $Res Function(Class) _then;

/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? name = null,Object? code = null,Object? kind = null,Object? lecturer = null,Object? range = null,Object? place = null,Object? groups = null,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ClassKind,lecturer: null == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as TimeRange,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as ClassPlace,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}
/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeRangeCopyWith<$Res> get range {
  
  return $TimeRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassPlaceCopyWith<$Res> get place {
  
  return $ClassPlaceCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [Class].
extension ClassPatterns on Class {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Class value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Class() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Class value)  $default,){
final _that = this;
switch (_that) {
case _Class():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Class value)?  $default,){
final _that = this;
switch (_that) {
case _Class() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  TimeRange range,  ClassPlace place,  List<Group> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Class() when $default != null:
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.range,_that.place,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  TimeRange range,  ClassPlace place,  List<Group> groups)  $default,) {final _that = this;
switch (_that) {
case _Class():
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.range,_that.place,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  TimeRange range,  ClassPlace place,  List<Group> groups)?  $default,) {final _that = this;
switch (_that) {
case _Class() when $default != null:
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.range,_that.place,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Class implements Class {
  const _Class({required this.classId, required this.name, required this.code, required this.kind, required this.lecturer, required this.range, required this.place, required final  List<Group> groups}): _groups = groups;
  factory _Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);

@override final  String classId;
@override final  String name;
@override final  String code;
@override final  ClassKind kind;
@override final  String lecturer;
@override final  TimeRange range;
@override final  ClassPlace place;
 final  List<Group> _groups;
@override List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassCopyWith<_Class> get copyWith => __$ClassCopyWithImpl<_Class>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Class&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.range, range) || other.range == range)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,code,kind,lecturer,range,place,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'Class(classId: $classId, name: $name, code: $code, kind: $kind, lecturer: $lecturer, range: $range, place: $place, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$ClassCopyWith<$Res> implements $ClassCopyWith<$Res> {
  factory _$ClassCopyWith(_Class value, $Res Function(_Class) _then) = __$ClassCopyWithImpl;
@override @useResult
$Res call({
 String classId, String name, String code, ClassKind kind, String lecturer, TimeRange range, ClassPlace place, List<Group> groups
});


@override $TimeRangeCopyWith<$Res> get range;@override $ClassPlaceCopyWith<$Res> get place;

}
/// @nodoc
class __$ClassCopyWithImpl<$Res>
    implements _$ClassCopyWith<$Res> {
  __$ClassCopyWithImpl(this._self, this._then);

  final _Class _self;
  final $Res Function(_Class) _then;

/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? name = null,Object? code = null,Object? kind = null,Object? lecturer = null,Object? range = null,Object? place = null,Object? groups = null,}) {
  return _then(_Class(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ClassKind,lecturer: null == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as TimeRange,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as ClassPlace,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}

/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeRangeCopyWith<$Res> get range {
  
  return $TimeRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}/// Create a copy of Class
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassPlaceCopyWith<$Res> get place {
  
  return $ClassPlaceCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}

// dart format on
