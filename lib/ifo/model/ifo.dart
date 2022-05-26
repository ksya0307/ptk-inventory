import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ifo.g.dart';

@JsonSerializable()
class Ifo extends Equatable {
  final int id;
  final String name;
  const Ifo({required this.id, required this.name});

  factory Ifo.fromJson(Map<String, dynamic> json) => _$IfoFromJson(json);

  @override
  List<Object?> get props => [id, name];
}
