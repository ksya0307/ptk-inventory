import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';

part 'user.g.dart';

//equatable - для сравнивания объектов
///Модель для [User] для нашего случая
@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.surname,
    required this.name,
    this.patronymic,
    required this.username,
    required this.role,
    this.accessToken,
    this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  ///текущий id пользователя
  final int id;

  ///текущее ФИО
  final String surname;
  final String name;
  final String? patronymic;

  ///текущий username
  final String username;

  ///текущая роль
  final UserRole role;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(
    id: 0,
    surname: '',
    name: '',
    patronymic: '',
    username: '',
    role: UserRole.common,
    accessToken: '',
    refreshToken: '',
  );

  //It's useful to define a static empty User so that we don't have to handle null Users and can always work with a concrete User object.
  ///Удобный геттер для определения того, пуст ли текущий пользователь.
  bool get isEmpty => this == User.empty;

  ///Удобный геттер для определения того, не пуст ли текущий пользователь.
  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromHiveToUser(UserHiveModel userHiveModel) => User(
        id: userHiveModel.id,
        surname: userHiveModel.surname,
        name: userHiveModel.name,
        patronymic: userHiveModel.patronymic,
        username: userHiveModel.username,
        role: UserRole.values.byName(userHiveModel.userRole.toLowerCase()),
        accessToken: userHiveModel.accessToken,
        refreshToken: userHiveModel.refreshToken,
      );

  Map<String, dynamic> toJson() => _$UserToJson(this);

  //props - properties
  //список свойств, которые будут использоваться для сравнения двух объектов этого класса
  @override
  List<Object?> get props => [
        id,
        surname,
        name,
        patronymic,
        username,
        role,
        accessToken,
        refreshToken
      ];
}
