// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoryResult _$CategoryResultFromJson(Map<String, dynamic> json) {
  return _CategoryResult.fromJson(json);
}

/// @nodoc
class _$CategoryResultTearOff {
  const _$CategoryResultTearOff();

  _CategoryResult call({List<Category> result = const []}) {
    return _CategoryResult(
      result: result,
    );
  }

  CategoryResult fromJson(Map<String, Object?> json) {
    return CategoryResult.fromJson(json);
  }
}

/// @nodoc
const $CategoryResult = _$CategoryResultTearOff();

/// @nodoc
mixin _$CategoryResult {
  List<Category> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryResultCopyWith<CategoryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryResultCopyWith<$Res> {
  factory $CategoryResultCopyWith(
          CategoryResult value, $Res Function(CategoryResult) then) =
      _$CategoryResultCopyWithImpl<$Res>;
  $Res call({List<Category> result});
}

/// @nodoc
class _$CategoryResultCopyWithImpl<$Res>
    implements $CategoryResultCopyWith<$Res> {
  _$CategoryResultCopyWithImpl(this._value, this._then);

  final CategoryResult _value;
  // ignore: unused_field
  final $Res Function(CategoryResult) _then;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc
abstract class _$CategoryResultCopyWith<$Res>
    implements $CategoryResultCopyWith<$Res> {
  factory _$CategoryResultCopyWith(
          _CategoryResult value, $Res Function(_CategoryResult) then) =
      __$CategoryResultCopyWithImpl<$Res>;
  @override
  $Res call({List<Category> result});
}

/// @nodoc
class __$CategoryResultCopyWithImpl<$Res>
    extends _$CategoryResultCopyWithImpl<$Res>
    implements _$CategoryResultCopyWith<$Res> {
  __$CategoryResultCopyWithImpl(
      _CategoryResult _value, $Res Function(_CategoryResult) _then)
      : super(_value, (v) => _then(v as _CategoryResult));

  @override
  _CategoryResult get _value => super._value as _CategoryResult;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_CategoryResult(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategoryResult implements _CategoryResult {
  _$_CategoryResult({this.result = const []});

  factory _$_CategoryResult.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryResultFromJson(json);

  @JsonKey()
  @override
  final List<Category> result;

  @override
  String toString() {
    return 'CategoryResult(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryResult &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$CategoryResultCopyWith<_CategoryResult> get copyWith =>
      __$CategoryResultCopyWithImpl<_CategoryResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryResultToJson(this);
  }
}

abstract class _CategoryResult implements CategoryResult {
  factory _CategoryResult({List<Category> result}) = _$_CategoryResult;

  factory _CategoryResult.fromJson(Map<String, dynamic> json) =
      _$_CategoryResult.fromJson;

  @override
  List<Category> get result;
  @override
  @JsonKey(ignore: true)
  _$CategoryResultCopyWith<_CategoryResult> get copyWith =>
      throw _privateConstructorUsedError;
}
