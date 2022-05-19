// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentResult _$$_DocumentResultFromJson(Map<String, dynamic> json) =>
    _$_DocumentResult(
      result: (json['result'] as List<dynamic>?)
              ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_DocumentResultToJson(_$_DocumentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
