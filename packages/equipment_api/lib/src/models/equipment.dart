import 'category.dart';

import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipment {
  final int id;
  final String description;
  final Category category;

  Equipment({required this.id, required this.description, required this.category});

  factory Equipment.fromJson(Map<String, dynamic> json) => _$EquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);

}
