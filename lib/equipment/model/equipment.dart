import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/category/model/category.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipment extends Equatable {
  final int id;
  final String description;
  final Category category;

  const Equipment({
    required this.id,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [id, description, category];

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);
}
