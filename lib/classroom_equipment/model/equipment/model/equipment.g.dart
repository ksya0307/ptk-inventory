// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      id: json['id'] as int,
      description: json['description'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'category': instance.category,
    };
