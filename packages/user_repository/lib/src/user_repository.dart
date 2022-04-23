import 'dart:async';

import 'package:user_api/user_api.dart' hide User;
import 'package:user_repository/user_repository.dart';

class UserFailure implements Exception {}

//Цель репозитория это обеспечить интерфейс, который абстрагирует наши запросы к апи
//Абстрагировать "что" от "как", тоесть мы хотим иметь способ получения данных, а не о том откуда они поступают
class UserRepository {
  UserRepository({UserApiClient? userApiClient})
      : _userApiClient = userApiClient ?? UserApiClient();

  final UserApiClient _userApiClient;

  //тут мы делаем запрос к нашему Data Provider, в котором запросы к апи
  //с ним взаимодействует Bloc Layer
  Future<User> getUser(String username, String password) async {
    final data = await _userApiClient.signIn(username, password);
    final accessToken = data.accessToken;
    final refreshToken = data.refreshToken;
    final userId = data.userId;
    final user = await _userApiClient.getUser(accessToken, userId);
    return User(
      id: userId,
      surname: user.surname,
      name: user.name,
      patronymic: user.patronymic,
      username: user.username,
      role: user.role.toRole,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
extension on UserRole{
  Role get toRole{
    switch(this){
      case UserRole.MODERATOR: return Role.MODERATOR;
      case UserRole.READER: return Role.READER;
    }
  }
}