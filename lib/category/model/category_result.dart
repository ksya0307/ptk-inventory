import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ptk_inventory/category/model/category.dart';

part 'category_result.g.dart';

@JsonSerializable()
class CategoryResult extends Equatable {
  const CategoryResult({required this.result});

  final List<Category> result;

  factory CategoryResult.fromJson(Map<String, dynamic> json) =>
      _$CategoryResultFromJson(json);

  @override
  List<Object?> get props => [result];
}
