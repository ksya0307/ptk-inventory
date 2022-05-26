import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/common/model/user.dart';

part 'classroom.g.dart';

@JsonSerializable()
class Classroom extends Equatable {
  final String number;
  final User user;
  const Classroom({required this.number, required this.user});

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);

  @override
  List<Object?> get props => [number, user];
}
