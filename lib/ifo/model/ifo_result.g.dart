// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ifo_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IfoResult _$$_IfoResultFromJson(Map<String, dynamic> json) => _$_IfoResult(
      result: (json['result'] as List<dynamic>?)
              ?.map((e) => Ifo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_IfoResultToJson(_$_IfoResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
