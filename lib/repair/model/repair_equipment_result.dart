import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/repair/model/repair_equipment.dart';

part 'repair_equipment_result.g.dart';

@JsonSerializable()
class RepairEquipmentResult extends Equatable {
  final List<RepairEquipment> result;
  const RepairEquipmentResult({required this.result});

  factory RepairEquipmentResult.fromJson(Map<String, dynamic> json) =>
      _$RepairEquipmentResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
