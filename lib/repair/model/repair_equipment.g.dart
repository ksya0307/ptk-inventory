// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairEquipment _$RepairEquipmentFromJson(Map<String, dynamic> json) =>
    RepairEquipment(
      id: json['id'] as int,
      problem: json['problem'] as String,
      repair: Repair.fromJson(json['repair'] as Map<String, dynamic>),
      equipment: ClassroomEquipment.fromJson(
          json['equipment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepairEquipmentToJson(RepairEquipment instance) =>
    <String, dynamic>{
      'repair': instance.repair,
      'equipment': instance.equipment,
      'problem': instance.problem,
      'id': instance.id,
    };
