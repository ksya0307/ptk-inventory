import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse{
  final String accessToken;
  final String refreshToken;
  final int userId;

  AuthResponse( this.accessToken,  this.refreshToken,  this.userId);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
