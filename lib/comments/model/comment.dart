import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment extends Equatable {
  final int id;
  final String comment;
  final Inventory inventory;
  final User user;
  final DateTime datetime;
  const Comment({
    required this.id,
    required this.comment,
    required this.inventory,
    required this.user,
    required this.datetime,
  });

    @override
  List<Object?> get props => [id, comment, inventory, user,datetime, ];

    factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
