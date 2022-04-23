import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Role { MODERATOR, READER }

//equatable - для сравнивания объектов
///Модель для [User] для нашего случая
@JsonSerializable()
class User extends Equatable {
  const User(
      {required this.id,
      this.surname,
      this.name,
      this.patronymic,
      this.username,
      this.role,
      this.accessToken,
      this.refreshToken});

  final String? accessToken;
  final String? refreshToken;

  ///текущий id пользователя
  final int id;

  ///текущее ФИО
  final String? surname;
  final String? name;
  final String? patronymic;

  ///текущий username
  final String? username;

  ///текущая роль
  final Role? role;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 0);

  //It's useful to define a static empty User so that we don't have to handle null Users and can always work with a concrete User object.
  ///Удобный геттер для определения того, пуст ли текущий пользователь.
  bool get isEmpty => this == User.empty;

  ///Удобный геттер для определения того, не пуст ли текущий пользователь.
  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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
