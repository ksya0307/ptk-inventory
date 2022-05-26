// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repair _$RepairFromJson(Map<String, dynamic> json) => Repair(
      id: json['id'] as int,
      phone: json['phone'] as String,
      datetime: DateTime.parse(json['datetime'] as String),
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$RepairToJson(Repair instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'datetime': instance.datetime.toIso8601String(),
      'completed': instance.completed,
    };
