// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment_types.dart';

import 'package:ptk_inventory/classrooms/model/classroom.dart';


part 'classroom_equipment.g.dart';

@JsonSerializable()
class ClassroomEquipment extends Equatable {
  final int id;
  @JsonKey(name: "inventory_number")
  final int inventoryNumber;
  final Classroom classroom;
  final Equipment equipment;
  @JsonKey(name: "number_in_classroom")
  final String numberInClassroom;
  @JsonKey(name: "equipment_type")
  final EquipmentBelonging equipmentType;
  bool isChecked;
  ClassroomEquipment({
    required this.id,
    required this.inventoryNumber,
    required this.classroom,
    required this.equipment,
    required this.numberInClassroom,
    required this.equipmentType,
    this.isChecked = false,
  });

  factory ClassroomEquipment.fromJson(Map<String, dynamic> json) =>
      _$ClassroomEquipmentFromJson(json);

  @override
  List<Object?> get props => [
        id,
        inventoryNumber,
        classroom,
        equipment,
        numberInClassroom,
        equipmentType,
        isChecked,
      ];
}
