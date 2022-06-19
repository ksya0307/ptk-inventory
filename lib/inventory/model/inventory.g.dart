// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      id: json['id'] as int,
      inventoryNumber: ClassroomEquipment.fromJson(
          json['inventory_number'] as Map<String, dynamic>),
      getDate: DateTime.parse(json['get_date'] as String),
      document: Document.fromJson(json['document'] as Map<String, dynamic>),
      ifo: Ifo.fromJson(json['ifo'] as Map<String, dynamic>),
      forClassroom:
          Classroom.fromJson(json['for_classroom'] as Map<String, dynamic>),
      given: json['given'] as bool,
      byRequest: json['by_request'] as bool,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'id': instance.id,
      'inventory_number': instance.inventoryNumber,
      'get_date': instance.getDate.toIso8601String(),
      'document': instance.document,
      'ifo': instance.ifo,
      'for_classroom': instance.forClassroom,
      'given': instance.given,
      'by_request': instance.byRequest,
    };
