import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../user_api.dart';

///Exception thrown when [signIn] fails
class LogInRequestFailure implements Exception {
  LogInRequestFailure(String s);
}

///Exception thrown when [signIn] is not found
class LogInNotFoundFailure implements Exception {}

///Exception thrown when [getUser] fails, when username and password are incorrect
class GetUserRequestFailure implements Exception {
  const GetUserRequestFailure(String s);
}

///Класс для создания http запросов
//Слой Data Provider, самый низший
class UserApiClient {
  UserApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const _baseUrl = 'ktor-equipment-inventory.herokuapp.com';

  ///Авторизация и получение токенов для дальнейшего доступа к данным
  Future<AuthResponse> signIn(String username, String password) async {
    final request = Uri.https(_baseUrl, '/api/v1/login');
    final response = await _httpClient.post(request,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonAnswer = jsonDecode(response.body) ;
      print('!!!!!!!!!!!!!!!!!! $jsonAnswer');
      return AuthResponse.fromJson(jsonAnswer);
    } else {
      throw LogInRequestFailure("User Sign In Failed");
    }
  }

  ///Получение [User] по заданному [user_id] и [accessToken]
  Future<User> getUser(String accessToken, int user_id) async {
    final request = Uri.https(_baseUrl, '/api/v1/users/$user_id');
    final response = await _httpClient.get(request, headers: {"Authorization": "Bearer $accessToken"});

    if (response.statusCode != 200) {
      throw GetUserRequestFailure("Get User Failed");
    }
    {
      final Map<String, dynamic> userJson = jsonDecode(response.body);
      return User.fromJson(userJson );
    }
  }
}
