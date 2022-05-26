import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/equipment_classrooms/add_equipment/view/equipment_belongings_radio_buttons.dart';

part 'classroom_equipment.g.dart';

@JsonSerializable()
class ClassroomEquipment extends Equatable {
  final int id;
  @JsonValue("inventory_number")
  final int inventoryNumber;
  final Classroom classroom;
  @JsonValue("number_in_classroom")
  final String numberInClassroom;
  @JsonValue("equipment_type")
  final EquipmentBelonging equipmentType;
  const ClassroomEquipment({
    required this.id,
    required this.inventoryNumber,
    required this.classroom,
    required this.numberInClassroom,
    required this.equipmentType,
  });

  factory ClassroomEquipment.fromJson(Map<String, dynamic> json) =>
      _$ClassroomEquipmentFromJson(json);

  @override
  List<Object?> get props => [
        id,
        inventoryNumber,
        classroom,
        numberInClassroom,
        equipmentType,
      ];
}
