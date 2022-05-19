// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'document_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentResult _$DocumentResultFromJson(Map<String, dynamic> json) {
  return _DocumentResult.fromJson(json);
}

/// @nodoc
class _$DocumentResultTearOff {
  const _$DocumentResultTearOff();

  _DocumentResult call({List<Document> result = const []}) {
    return _DocumentResult(
      result: result,
    );
  }

  DocumentResult fromJson(Map<String, Object?> json) {
    return DocumentResult.fromJson(json);
  }
}

/// @nodoc
const $DocumentResult = _$DocumentResultTearOff();

/// @nodoc
mixin _$DocumentResult {
  List<Document> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentResultCopyWith<DocumentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentResultCopyWith<$Res> {
  factory $DocumentResultCopyWith(
          DocumentResult value, $Res Function(DocumentResult) then) =
      _$DocumentResultCopyWithImpl<$Res>;
  $Res call({List<Document> result});
}

/// @nodoc
class _$DocumentResultCopyWithImpl<$Res>
    implements $DocumentResultCopyWith<$Res> {
  _$DocumentResultCopyWithImpl(this._value, this._then);

  final DocumentResult _value;
  // ignore: unused_field
  final $Res Function(DocumentResult) _then;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Document>,
    ));
  }
}

/// @nodoc
abstract class _$DocumentResultCopyWith<$Res>
    implements $DocumentResultCopyWith<$Res> {
  factory _$DocumentResultCopyWith(
          _DocumentResult value, $Res Function(_DocumentResult) then) =
      __$DocumentResultCopyWithImpl<$Res>;
  @override
  $Res call({List<Document> result});
}

/// @nodoc
class __$DocumentResultCopyWithImpl<$Res>
    extends _$DocumentResultCopyWithImpl<$Res>
    implements _$DocumentResultCopyWith<$Res> {
  __$DocumentResultCopyWithImpl(
      _DocumentResult _value, $Res Function(_DocumentResult) _then)
      : super(_value, (v) => _then(v as _DocumentResult));

  @override
  _DocumentResult get _value => super._value as _DocumentResult;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_DocumentResult(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Document>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentResult implements _DocumentResult {
  _$_DocumentResult({this.result = const []});

  factory _$_DocumentResult.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentResultFromJson(json);

  @JsonKey()
  @override
  final List<Document> result;

  @override
  String toString() {
    return 'DocumentResult(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocumentResult &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$DocumentResultCopyWith<_DocumentResult> get copyWith =>
      __$DocumentResultCopyWithImpl<_DocumentResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentResultToJson(this);
  }
}

abstract class _DocumentResult implements DocumentResult {
  factory _DocumentResult({List<Document> result}) = _$_DocumentResult;

  factory _DocumentResult.fromJson(Map<String, dynamic> json) =
      _$_DocumentResult.fromJson;

  @override
  List<Document> get result;
  @override
  @JsonKey(ignore: true)
  _$DocumentResultCopyWith<_DocumentResult> get copyWith =>
      throw _privateConstructorUsedError;
}
