///Модель [User] для данных, отображаемые нашим приложением

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
      {required this.surname,
      required this.name,
      required this.patronymic,
      required this.username});

  final String surname;
  final String name;
  final String patronymic;
  final String username;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromRepository(user_repository.User user) {
    return User(
        surname: user.surname,
        name: user.name,
        patronymic: user.patronymic,
        username: user.username);
  }

  static const empty =
      User(surname: '-', name: '-', patronymic: '-', username: '-');

  Map<String, dynamic> toJson() => _$UserToJson(this);

  ///Пустой пользователь, который представляет неаутентифицированного пользователя.

  @override
  List<Object> get props => [surname, name, patronymic, username];

  User copyWith(
      {String? surname, String? name, String? patronymic, String? username}) {
    return User(
        surname: surname ?? this.surname,
        name: name ?? this.name,
        patronymic: patronymic ?? this.patronymic,
        username: username ?? this.username);
  }
}
