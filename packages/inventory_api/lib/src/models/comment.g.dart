// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as int,
      Inventory.fromJson(json['inventory'] as Map<String, dynamic>),
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['comment'] as String,
      DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'inventory': instance.inventory,
      'user': instance.user,
      'comment': instance.comment,
      'datetime': instance.datetime.toIso8601String(),
    };
