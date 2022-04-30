// import 'classroom.dart';
// import 'equipment.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'classroom_equipment.g.dart';


// enum EquipmentBelonging {
//   @JsonValue("Учебно-лабораторное оборудование")
//   LAB,
//   @JsonValue("Учебно-производственное оборудование")
//   PROD,
//   @JsonValue("Другое")
//   OTHER,
// }

// @JsonSerializable()
// class ClassroomEquipment {
//   final int id;
//   final int inventory_number;
//   final Classroom classroom;
//   final Equipment equipment;
//   final String number_in_classroom;
//   final EquipmentBelonging equipment_type;

//   ClassroomEquipment(
//       {required this.id,
//       required this.inventory_number,
//       required this.classroom,
//       required this.equipment,
//       required this.number_in_classroom,
//       required this.equipment_type});

//   factory ClassroomEquipment.fromJson(Map<String, dynamic> json) => _$ClassroomEquipmentFromJson(json);

//   Map<String, dynamic> toJson() => _$ClassroomEquipmentToJson(this);
// }
