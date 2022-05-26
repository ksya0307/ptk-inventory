// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_equipment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomEquipmentResult _$ClassroomEquipmentResultFromJson(
        Map<String, dynamic> json) =>
    ClassroomEquipmentResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => ClassroomEquipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassroomEquipmentResultToJson(
        ClassroomEquipmentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
