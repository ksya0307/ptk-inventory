// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentResult _$EquipmentResultFromJson(Map<String, dynamic> json) =>
    EquipmentResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipmentResultToJson(EquipmentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
