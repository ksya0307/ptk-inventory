// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.initial,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'status': _$UserStatusEnumMap[instance.status],
      'user': instance.user.toJson(),
    };

const _$UserStatusEnumMap = {
  UserStatus.initial: 'initial',
  UserStatus.loading: 'loading',
  UserStatus.success: 'success',
  UserStatus.failure: 'failure',
};
