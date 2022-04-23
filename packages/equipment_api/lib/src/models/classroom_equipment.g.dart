// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomEquipment _$ClassroomEquipmentFromJson(Map<String, dynamic> json) =>
    ClassroomEquipment(
      id: json['id'] as int,
      inventory_number: json['inventory_number'] as int,
      classroom: Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
      equipment: Equipment.fromJson(json['equipment'] as Map<String, dynamic>),
      number_in_classroom: json['number_in_classroom'] as String,
      equipment_type:
          $enumDecode(_$EquipmentBelongingEnumMap, json['equipment_type']),
    );

Map<String, dynamic> _$ClassroomEquipmentToJson(ClassroomEquipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventory_number': instance.inventory_number,
      'classroom': instance.classroom,
      'equipment': instance.equipment,
      'number_in_classroom': instance.number_in_classroom,
      'equipment_type': _$EquipmentBelongingEnumMap[instance.equipment_type],
    };

const _$EquipmentBelongingEnumMap = {
  EquipmentBelonging.LAB: 'Учебно-лабораторное оборудование',
  EquipmentBelonging.PROD: 'Учебно-производственное оборудование',
};
