import 'package:user_api/user_api.dart';

import 'inventory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final Inventory inventory;
  final User user;
  final String comment;
  final DateTime datetime;

  Comment(this.id, this.inventory, this.user, this.comment, this.datetime);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
      // : id = json['id'],
      //   inventory = Inventory.fromJson(json['inventory']),
      //   user = User.fromJson(json['user']),
      //   comment = json['comment'],
      //   datetime = json['datetime'];

  Map<String, dynamic> toJson() => _$CommentToJson(this);
      // {
      //   'id': id,
      //   'inventory': inventory.toJson(),
      //   'user': user.toJson(),
      //   'comment': comment,
      //   'datetime': datetime,
      // };
}
