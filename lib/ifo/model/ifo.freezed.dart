// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ifo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ifo _$IfoFromJson(Map<String, dynamic> json) {
  return _Ifo.fromJson(json);
}

/// @nodoc
class _$IfoTearOff {
  const _$IfoTearOff();

  _Ifo call({required int id, required String name}) {
    return _Ifo(
      id: id,
      name: name,
    );
  }

  Ifo fromJson(Map<String, Object?> json) {
    return Ifo.fromJson(json);
  }
}

/// @nodoc
const $Ifo = _$IfoTearOff();

/// @nodoc
mixin _$Ifo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IfoCopyWith<Ifo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IfoCopyWith<$Res> {
  factory $IfoCopyWith(Ifo value, $Res Function(Ifo) then) =
      _$IfoCopyWithImpl<$Res>;
  $Res call({int id, String name});
}

/// @nodoc
class _$IfoCopyWithImpl<$Res> implements $IfoCopyWith<$Res> {
  _$IfoCopyWithImpl(this._value, this._then);

  final Ifo _value;
  // ignore: unused_field
  final $Res Function(Ifo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$IfoCopyWith<$Res> implements $IfoCopyWith<$Res> {
  factory _$IfoCopyWith(_Ifo value, $Res Function(_Ifo) then) =
      __$IfoCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name});
}

/// @nodoc
class __$IfoCopyWithImpl<$Res> extends _$IfoCopyWithImpl<$Res>
    implements _$IfoCopyWith<$Res> {
  __$IfoCopyWithImpl(_Ifo _value, $Res Function(_Ifo) _then)
      : super(_value, (v) => _then(v as _Ifo));

  @override
  _Ifo get _value => super._value as _Ifo;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_Ifo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ifo implements _Ifo {
  _$_Ifo({required this.id, required this.name});

  factory _$_Ifo.fromJson(Map<String, dynamic> json) => _$$_IfoFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'Ifo(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ifo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$IfoCopyWith<_Ifo> get copyWith =>
      __$IfoCopyWithImpl<_Ifo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IfoToJson(this);
  }
}

abstract class _Ifo implements Ifo {
  factory _Ifo({required int id, required String name}) = _$_Ifo;

  factory _Ifo.fromJson(Map<String, dynamic> json) = _$_Ifo.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$IfoCopyWith<_Ifo> get copyWith => throw _privateConstructorUsedError;
}
