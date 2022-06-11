// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairEquipment _$RepairEquipmentFromJson(Map<String, dynamic> json) =>
    RepairEquipment(
      json['id'] as int,
      json['problem'] as String,
      repair: Repair.fromJson(json['repair_id'] as Map<String, dynamic>),
      equipment: ClassroomEquipment.fromJson(
          json['equipment_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepairEquipmentToJson(RepairEquipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repair_id': instance.repair,
      'equipment_id': instance.equipment,
      'problem': instance.problem,
    };
