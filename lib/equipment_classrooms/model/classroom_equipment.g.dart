// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassroomEquipment _$ClassroomEquipmentFromJson(Map<String, dynamic> json) =>
    ClassroomEquipment(
      id: json['id'] as int,
      inventoryNumber: json['inventoryNumber'] as int,
      classroom: Classroom.fromJson(json['classroom'] as Map<String, dynamic>),
      numberInClassroom: json['numberInClassroom'] as String,
      equipmentType:
          $enumDecode(_$EquipmentBelongingEnumMap, json['equipmentType']),
    );

Map<String, dynamic> _$ClassroomEquipmentToJson(ClassroomEquipment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventoryNumber': instance.inventoryNumber,
      'classroom': instance.classroom,
      'numberInClassroom': instance.numberInClassroom,
      'equipmentType': _$EquipmentBelongingEnumMap[instance.equipmentType],
    };

const _$EquipmentBelongingEnumMap = {
  EquipmentBelonging.lab: 'lab',
  EquipmentBelonging.prod: 'prod',
  EquipmentBelonging.other: 'other',
};
