// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResult _$CommentResultFromJson(Map<String, dynamic> json) =>
    CommentResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentResultToJson(CommentResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
