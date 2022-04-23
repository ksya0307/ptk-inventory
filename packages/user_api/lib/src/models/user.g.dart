// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['surname'] as String,
      json['name'] as String,
      json['patronymic'] as String,
      json['username'] as String,
      $enumDecode(_$UserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'surname': instance.surname,
      'name': instance.name,
      'patronymic': instance.patronymic,
      'username': instance.username,
      'role': _$UserRoleEnumMap[instance.role],
    };

const _$UserRoleEnumMap = {
  UserRole.MODERATOR: 'MODERATOR',
  UserRole.READER: 'READER',
};
