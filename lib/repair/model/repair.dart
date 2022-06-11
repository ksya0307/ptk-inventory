import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repair.g.dart';

@JsonSerializable()
class Repair extends Equatable {
  final int id;
  final String phone;
  final DateTime datetime;
  final bool completed;

  const Repair({
    required this.id,
    required this.phone,
    required this.datetime,
    required this.completed,
  });

  factory Repair.fromJson(Map<String, dynamic> json) => _$RepairFromJson(json);

  @override
  List<Object?> get props => [id, phone, datetime, completed];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'datetime': datetime.toIso8601String(),
      'completed': completed,
    };
  }
}
