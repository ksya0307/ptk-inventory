// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ifo_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IfoResult _$IfoResultFromJson(Map<String, dynamic> json) => IfoResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Ifo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IfoResultToJson(IfoResult instance) => <String, dynamic>{
      'result': instance.result,
    };
