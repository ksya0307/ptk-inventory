// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomResult _$ClassroomResultFromJson(Map<String, dynamic> json) =>
    ClassroomResult(
      (json['result'] as List<dynamic>)
          .map((e) => Classroom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassroomResultToJson(ClassroomResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
