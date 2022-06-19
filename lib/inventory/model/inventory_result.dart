import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';

part 'inventory_result.g.dart';

@JsonSerializable()
class InventoryResult extends Equatable {
  final List<Inventory> result;
  const InventoryResult({required this.result});
    factory InventoryResult.fromJson(Map<String, dynamic> json) =>
      _$InventoryResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
