// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int,
      comment: json['comment'] as String,
      inventory: Inventory.fromJson(json['inventory'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      datetime: DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'inventory': instance.inventory,
      'user': instance.user,
      'datetime': instance.datetime.toIso8601String(),
    };
