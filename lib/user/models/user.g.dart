// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      surname: json['surname'] as String,
      name: json['name'] as String,
      patronymic: json['patronymic'] as String,
      username: json['username'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'surname': instance.surname,
      'name': instance.name,
      'patronymic': instance.patronymic,
      'username': instance.username,
      'role': _$RoleEnumMap[instance.role],
    };

const _$RoleEnumMap = {
  Role.MODERATOR: 'MODERATOR',
  Role.READER: 'READER',
};
