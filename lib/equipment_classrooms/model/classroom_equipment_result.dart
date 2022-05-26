import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/equipment_classrooms/model/classroom_equipment.dart';

part 'classroom_equipment_result.g.dart';

@JsonSerializable()
class ClassroomEquipmentResult extends Equatable {
  final List<ClassroomEquipment> result;
  const ClassroomEquipmentResult({required this.result});

  factory ClassroomEquipmentResult.fromJson(Map<String, dynamic> json) =>
      _$ClassroomEquipmentResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
