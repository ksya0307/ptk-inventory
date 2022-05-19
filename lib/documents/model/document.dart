import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.g.dart';
part 'document.freezed.dart';

@freezed
class Document with _$Document {
  factory Document({required int id, required String name}) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}
