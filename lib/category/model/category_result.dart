import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ptk_inventory/category/model/category.dart';

part 'category_result.g.dart';
part 'category_result.freezed.dart';

@freezed
class CategoryResult with _$CategoryResult {
  factory CategoryResult({
    @Default([]) List<Category> result,
  }) = _CategoryResult;

  factory CategoryResult.fromJson(Map<String, dynamic> json) =>
      _$CategoryResultFromJson(json);
}
