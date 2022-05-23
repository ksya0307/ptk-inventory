import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/documents/model/document.dart';

part 'document_result.g.dart';

@JsonSerializable()
class DocumentResult extends Equatable {
  final List<Document> result;

  const DocumentResult(this.result);
  factory DocumentResult.fromJson(Map<String, dynamic> json) =>
      _$DocumentResultFromJson(json);

  @override
  List<Object?> get props => [result];
}
