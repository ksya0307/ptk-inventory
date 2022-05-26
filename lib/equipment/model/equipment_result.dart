import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/equipment/model/equipment.dart';

part 'equipment_result.g.dart';

@JsonSerializable()
class EquipmentResult extends Equatable {
  final List<Equipment> result;
  const EquipmentResult({required this.result});

  factory EquipmentResult.fromJson(Map<String, dynamic> json) =>
      _$EquipmentResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
