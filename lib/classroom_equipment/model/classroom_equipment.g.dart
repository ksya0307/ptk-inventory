// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomEquipment _$ClassroomEquipmentFromJson(Map<String, dynamic> json) =>
    ClassroomEquipment(
      id: json['id'] as int,
      inventoryNumber: json['inventory_number'] as int,
      classroom: Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
      equipment: Equipment.fromJson(json['equipment'] as Map<String, dynamic>),
      numberInClassroom: json['number_in_classroom'] as String,
      equipmentType:
          $enumDecode(_$EquipmentBelongingEnumMap, json['equipment_type']),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$ClassroomEquipmentToJson(ClassroomEquipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventory_number': instance.inventoryNumber,
      'classroom': instance.classroom,
      'equipment': instance.equipment,
      'number_in_classroom': instance.numberInClassroom,
      'equipment_type': _$EquipmentBelongingEnumMap[instance.equipmentType],
      'isChecked': instance.isChecked,
    };

const _$EquipmentBelongingEnumMap = {
  EquipmentBelonging.lab: 'LAB',
  EquipmentBelonging.prod: 'PROD',
  EquipmentBelonging.other: 'OTHER',
};
