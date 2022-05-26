import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/repair/model/repair.dart';

part 'repair_result.g.dart';

@JsonSerializable()
class RepairResult extends Equatable {
  final List<Repair> result;

  const RepairResult({required this.result});

  factory RepairResult.fromJson(Map<String, dynamic> json) =>
      _$RepairResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
