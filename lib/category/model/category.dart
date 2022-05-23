import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  const Category({required this.id, required this.name});
  final int id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  List<Object?> get props => [id, name];
}
