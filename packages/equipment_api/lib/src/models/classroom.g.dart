// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classroom _$ClassroomFromJson(Map<String, dynamic> json) => Classroom(
      number: json['number'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassroomToJson(Classroom instance) => <String, dynamic>{
      'number': instance.number,
      'user': instance.user,
    };
