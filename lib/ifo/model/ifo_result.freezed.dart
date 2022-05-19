// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ifo_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IfoResult _$IfoResultFromJson(Map<String, dynamic> json) {
  return _IfoResult.fromJson(json);
}

/// @nodoc
class _$IfoResultTearOff {
  const _$IfoResultTearOff();

  _IfoResult call({List<Ifo> result = const []}) {
    return _IfoResult(
      result: result,
    );
  }

  IfoResult fromJson(Map<String, Object?> json) {
    return IfoResult.fromJson(json);
  }
}

/// @nodoc
const $IfoResult = _$IfoResultTearOff();

/// @nodoc
mixin _$IfoResult {
  List<Ifo> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IfoResultCopyWith<IfoResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IfoResultCopyWith<$Res> {
  factory $IfoResultCopyWith(IfoResult value, $Res Function(IfoResult) then) =
      _$IfoResultCopyWithImpl<$Res>;
  $Res call({List<Ifo> result});
}

/// @nodoc
class _$IfoResultCopyWithImpl<$Res> implements $IfoResultCopyWith<$Res> {
  _$IfoResultCopyWithImpl(this._value, this._then);

  final IfoResult _value;
  // ignore: unused_field
  final $Res Function(IfoResult) _then;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Ifo>,
    ));
  }
}

/// @nodoc
abstract class _$IfoResultCopyWith<$Res> implements $IfoResultCopyWith<$Res> {
  factory _$IfoResultCopyWith(
          _IfoResult value, $Res Function(_IfoResult) then) =
      __$IfoResultCopyWithImpl<$Res>;
  @override
  $Res call({List<Ifo> result});
}

/// @nodoc
class __$IfoResultCopyWithImpl<$Res> extends _$IfoResultCopyWithImpl<$Res>
    implements _$IfoResultCopyWith<$Res> {
  __$IfoResultCopyWithImpl(_IfoResult _value, $Res Function(_IfoResult) _then)
      : super(_value, (v) => _then(v as _IfoResult));

  @override
  _IfoResult get _value => super._value as _IfoResult;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_IfoResult(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Ifo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IfoResult implements _IfoResult {
  _$_IfoResult({this.result = const []});

  factory _$_IfoResult.fromJson(Map<String, dynamic> json) =>
      _$$_IfoResultFromJson(json);

  @JsonKey()
  @override
  final List<Ifo> result;

  @override
  String toString() {
    return 'IfoResult(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IfoResult &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$IfoResultCopyWith<_IfoResult> get copyWith =>
      __$IfoResultCopyWithImpl<_IfoResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IfoResultToJson(this);
  }
}

abstract class _IfoResult implements IfoResult {
  factory _IfoResult({List<Ifo> result}) = _$_IfoResult;

  factory _IfoResult.fromJson(Map<String, dynamic> json) =
      _$_IfoResult.fromJson;

  @override
  List<Ifo> get result;
  @override
  @JsonKey(ignore: true)
  _$IfoResultCopyWith<_IfoResult> get copyWith =>
      throw _privateConstructorUsedError;
}
