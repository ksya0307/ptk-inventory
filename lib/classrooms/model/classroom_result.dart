import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';

part 'classroom_result.g.dart';

@JsonSerializable()
class ClassroomResult extends Equatable {
  final List<Classroom> result;

  const ClassroomResult(this.result);

  factory ClassroomResult.fromJson(Map<String, dynamic> json) =>
      _$ClassroomResultFromJson(json);

  @override
  List<Object?> get props => [result];
}
