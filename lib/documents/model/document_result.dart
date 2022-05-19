import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ptk_inventory/documents/model/document.dart';

part 'document_result.g.dart';
part 'document_result.freezed.dart';

@freezed
class DocumentResult with _$DocumentResult {
  factory DocumentResult({@Default([]) List<Document> result}) =
      _DocumentResult;

  factory DocumentResult.fromJson(Map<String, dynamic> json) =>
      _$DocumentResultFromJson(json);
}
