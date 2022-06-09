// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      json['accessToken'] as String,
      json['refreshToken'] as String,
      json['accessTokenExpiredAt'] as int,
      json['refreshTokenExpiredAt'] as int,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiredAt': instance.accessTokenExpiredAt,
      'refreshTokenExpiredAt': instance.refreshTokenExpiredAt,
    };
