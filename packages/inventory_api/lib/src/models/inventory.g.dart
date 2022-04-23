// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      id: json['id'] as int,
      inventory_number: ClassroomEquipment.fromJson(
          json['inventory_number'] as Map<String, dynamic>),
      get_time: DateTime.parse(json['get_time'] as String),
      document: json['document'] as String,
      ifo: json['ifo'] as String,
      for_classroom:
          Classroom.fromJson(json['for_classroom'] as Map<String, dynamic>),
      given: json['given'] as bool,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'id': instance.id,
      'inventory_number': instance.inventory_number,
      'get_time': instance.get_time.toIso8601String(),
      'document': instance.document,
      'ifo': instance.ifo,
      'for_classroom': instance.for_classroom,
      'given': instance.given,
    };
