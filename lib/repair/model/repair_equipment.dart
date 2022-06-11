import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';

import 'package:ptk_inventory/repair/model/repair.dart';

part 'repair_equipment.g.dart';

@JsonSerializable()
class RepairEquipment extends Equatable {
  final int id;
  @JsonKey(name: "repair_id")
  final Repair repair;
  @JsonKey(name: "equipment_id")
  final ClassroomEquipment equipment;
  final String problem;
  const RepairEquipment(
    this.id,
    this.problem, {
    required this.repair,
    required this.equipment,
  });

  factory RepairEquipment.fromJson(Map<String, dynamic> json) =>
      _$RepairEquipmentFromJson(json);
  @override
  List<Object?> get props => [id, repair, equipment, problem];
}
