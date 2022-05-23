// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResult _$DocumentResultFromJson(Map<String, dynamic> json) =>
    DocumentResult(
      (json['result'] as List<dynamic>)
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentResultToJson(DocumentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
