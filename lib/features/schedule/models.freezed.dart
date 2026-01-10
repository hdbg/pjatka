// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
return onSite(_that);}
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
return onSite(_that.room);}
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
mixin _$ScheduledClass {

 String get classId; String get name; String get code; ClassKind get kind; String get lecturer; DateTime get start; DateTime get end; ClassPlace get place; List<String> get groups;
/// Create a copy of ScheduledClass
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledClassCopyWith<ScheduledClass> get copyWith => _$ScheduledClassCopyWithImpl<ScheduledClass>(this as ScheduledClass, _$identity);

  /// Serializes this ScheduledClass to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledClass&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,code,kind,lecturer,start,end,place,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'ScheduledClass(classId: $classId, name: $name, code: $code, kind: $kind, lecturer: $lecturer, start: $start, end: $end, place: $place, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $ScheduledClassCopyWith<$Res>  {
  factory $ScheduledClassCopyWith(ScheduledClass value, $Res Function(ScheduledClass) _then) = _$ScheduledClassCopyWithImpl;
@useResult
$Res call({
 String classId, String name, String code, ClassKind kind, String lecturer, DateTime start, DateTime end, ClassPlace place, List<String> groups
});


$ClassPlaceCopyWith<$Res> get place;

}
/// @nodoc
class _$ScheduledClassCopyWithImpl<$Res>
    implements $ScheduledClassCopyWith<$Res> {
  _$ScheduledClassCopyWithImpl(this._self, this._then);

  final ScheduledClass _self;
  final $Res Function(ScheduledClass) _then;

/// Create a copy of ScheduledClass
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = null,Object? name = null,Object? code = null,Object? kind = null,Object? lecturer = null,Object? start = null,Object? end = null,Object? place = null,Object? groups = null,}) {
  return _then(_self.copyWith(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ClassKind,lecturer: null == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as ClassPlace,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ScheduledClass
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassPlaceCopyWith<$Res> get place {
  
  return $ClassPlaceCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScheduledClass].
extension ScheduledClassPatterns on ScheduledClass {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledClass value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledClass() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledClass value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledClass():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledClass value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledClass() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  DateTime start,  DateTime end,  ClassPlace place,  List<String> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledClass() when $default != null:
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.start,_that.end,_that.place,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  DateTime start,  DateTime end,  ClassPlace place,  List<String> groups)  $default,) {final _that = this;
switch (_that) {
case _ScheduledClass():
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.start,_that.end,_that.place,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String classId,  String name,  String code,  ClassKind kind,  String lecturer,  DateTime start,  DateTime end,  ClassPlace place,  List<String> groups)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledClass() when $default != null:
return $default(_that.classId,_that.name,_that.code,_that.kind,_that.lecturer,_that.start,_that.end,_that.place,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduledClass implements ScheduledClass {
  const _ScheduledClass({required this.classId, required this.name, required this.code, required this.kind, required this.lecturer, required this.start, required this.end, required this.place, required final  List<String> groups}): _groups = groups;
  factory _ScheduledClass.fromJson(Map<String, dynamic> json) => _$ScheduledClassFromJson(json);

@override final  String classId;
@override final  String name;
@override final  String code;
@override final  ClassKind kind;
@override final  String lecturer;
@override final  DateTime start;
@override final  DateTime end;
@override final  ClassPlace place;
 final  List<String> _groups;
@override List<String> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of ScheduledClass
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledClassCopyWith<_ScheduledClass> get copyWith => __$ScheduledClassCopyWithImpl<_ScheduledClass>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduledClassToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledClass&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classId,name,code,kind,lecturer,start,end,place,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'ScheduledClass(classId: $classId, name: $name, code: $code, kind: $kind, lecturer: $lecturer, start: $start, end: $end, place: $place, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$ScheduledClassCopyWith<$Res> implements $ScheduledClassCopyWith<$Res> {
  factory _$ScheduledClassCopyWith(_ScheduledClass value, $Res Function(_ScheduledClass) _then) = __$ScheduledClassCopyWithImpl;
@override @useResult
$Res call({
 String classId, String name, String code, ClassKind kind, String lecturer, DateTime start, DateTime end, ClassPlace place, List<String> groups
});


@override $ClassPlaceCopyWith<$Res> get place;

}
/// @nodoc
class __$ScheduledClassCopyWithImpl<$Res>
    implements _$ScheduledClassCopyWith<$Res> {
  __$ScheduledClassCopyWithImpl(this._self, this._then);

  final _ScheduledClass _self;
  final $Res Function(_ScheduledClass) _then;

/// Create a copy of ScheduledClass
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = null,Object? name = null,Object? code = null,Object? kind = null,Object? lecturer = null,Object? start = null,Object? end = null,Object? place = null,Object? groups = null,}) {
  return _then(_ScheduledClass(
classId: null == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ClassKind,lecturer: null == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as ClassPlace,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ScheduledClass
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
