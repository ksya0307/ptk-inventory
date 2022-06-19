import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ptk_inventory/comments/model/comment.dart';

part 'comment_result.g.dart';

@JsonSerializable()
class CommentResult extends Equatable {
  final List<Comment> result;
  const CommentResult({
    required this.result,
  });
  factory CommentResult.fromJson(Map<String, dynamic> json) =>
      _$CommentResultFromJson(json);
  @override
  List<Object?> get props => [result];
}
