// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairResult _$RepairResultFromJson(Map<String, dynamic> json) => RepairResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Repair.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RepairResultToJson(RepairResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
