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
/// @nodoc
mixin _$ClassPlace {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlace);
}


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


class ClassPlaceOnline implements ClassPlace {
  const ClassPlaceOnline();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlaceOnline);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClassPlace.online()';
}


}




/// @nodoc


class ClassPlaceOnSite implements ClassPlace {
  const ClassPlaceOnSite({required this.room});
  

 final  String room;

/// Create a copy of ClassPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassPlaceOnSiteCopyWith<ClassPlaceOnSite> get copyWith => _$ClassPlaceOnSiteCopyWithImpl<ClassPlaceOnSite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassPlaceOnSite&&(identical(other.room, room) || other.room == room));
}


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

// dart format on
