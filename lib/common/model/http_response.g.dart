// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponse _$HttpResponseFromJson(Map<String, dynamic> json) => HttpResponse(
      json['statusCode'] as int,
      json['message'] as String,
      $enumDecode(_$ResponseStatusEnumMap, json['responseStatus']),
    );

Map<String, dynamic> _$HttpResponseToJson(HttpResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'responseStatus': _$ResponseStatusEnumMap[instance.responseStatus],
    };

const _$ResponseStatusEnumMap = {
  ResponseStatus.success: 'success',
  ResponseStatus.failure: 'failure',
};
