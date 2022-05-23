// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResult _$CategoryResultFromJson(Map<String, dynamic> json) =>
    CategoryResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResultToJson(CategoryResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
