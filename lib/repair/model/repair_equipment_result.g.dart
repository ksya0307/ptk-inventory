// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_equipment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairEquipmentResult _$RepairEquipmentResultFromJson(
        Map<String, dynamic> json) =>
    RepairEquipmentResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => RepairEquipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RepairEquipmentResultToJson(
        RepairEquipmentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
