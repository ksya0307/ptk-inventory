// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryResult _$$_CategoryResultFromJson(Map<String, dynamic> json) =>
    _$_CategoryResult(
      result: (json['result'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CategoryResultToJson(_$_CategoryResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
