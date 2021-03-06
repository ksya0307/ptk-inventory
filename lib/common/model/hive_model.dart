// Package imports:
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hive_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String surname;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? patronymic;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String userRole;
  @HiveField(6)
  final String accessToken;
  @HiveField(7)
  final String refreshToken;
  @HiveField(8)
  final int accessTokenExpiredAt;
  @HiveField(9)
  final int refreshTokenExpiredAt;

  const UserHiveModel({
    required this.id,
    required this.surname,
    required this.name,
    this.patronymic,
    required this.username,
    required this.userRole,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiredAt,
    required this.refreshTokenExpiredAt,
  });

  factory UserHiveModel.fromJson(Map<String, dynamic> json) =>
      _$UserHiveModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserHiveModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        surname,
        name,
        patronymic,
        username,
        userRole,
        accessToken,
        refreshToken,
        accessTokenExpiredAt,
        refreshTokenExpiredAt
      ];
}
