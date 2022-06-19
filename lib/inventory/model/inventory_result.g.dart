// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryResult _$InventoryResultFromJson(Map<String, dynamic> json) =>
    InventoryResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Inventory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InventoryResultToJson(InventoryResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
