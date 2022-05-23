import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
class Document extends Equatable {
  const Document({required this.id, required this.name});
  final int id;
  final String name;
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  @override
  List<Object?> get props => [id, name];
}
