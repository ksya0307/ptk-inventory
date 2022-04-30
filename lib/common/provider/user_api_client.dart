import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/auth_response.dart';
import 'package:ptk_inventory/common/model/user.dart';

///Exception thrown when [signIn] fails
class LogInRequestFailure implements Exception {
  final String message;
  LogInRequestFailure(this.message);
}

///Exception thrown when [signIn] is not found
class LogInNotFoundFailure implements Exception {}

///Exception thrown when [getUser] fails, when username and password are incorrect
class GetUserRequestFailure implements Exception {
  final String message;
  const GetUserRequestFailure(this.message);
}

///Exception thrown when [getNewPairOfTokens] fails
class GetNewPairOfTokensFailure implements Exception {}

///Класс для создания http запросов
//Слой Data Provider, самый низший
class UserProvider {
  UserProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  ///Авторизация и получение токенов для дальнейшего доступа к данным
  Future<AuthResponse> signIn(Map<String, dynamic> login) async {
    final request =
        Uri.https(ApiRoutes.base_url, ApiRoutes.api_route + ApiRoutes.login);
    final http.Response response = await _httpClient.post(
      request,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(login),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonAnswer =
          jsonDecode(response.body) as Map<String, dynamic>;
      print("json $jsonAnswer");
      return AuthResponse.fromJson(jsonAnswer);
    } else {
      throw LogInRequestFailure("User Sign In Failed");
    }
  }

  ///Получение [User] по заданному [user_id] и [accessToken]
  Future<User> getUser(Map<String, String> header, int userId) async {
    final request = Uri.https(
      ApiRoutes.base_url,
      ApiRoutes.api_route + ApiRoutes.users + userId.toString(),
    );
    print("$request");
    final response = await _httpClient.get(request, headers: header);
    print("body ${response.statusCode}");
    if (response.statusCode != 200) {
      throw const GetUserRequestFailure("Get User Failed");
    } else {
      final Map<String, dynamic> userJson =
          jsonDecode(response.body) as Map<String, dynamic>;
      print("WHAT ${User.fromJson(userJson)}");
      return User.fromJson(userJson);
    }
  }

  Future<AuthResponse> getNewPairOfTokens(Map<String, String> header) async {
    final request =
        Uri.https(ApiRoutes.base_url, ApiRoutes.api_route + ApiRoutes.refresh);
    final response = await _httpClient.get(request, headers: header);

    if (response.statusCode != 200) {
      throw GetNewPairOfTokensFailure();
    } else {
      final Map<String, dynamic> jsonAnswer =
          jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(jsonAnswer);
    }
  }
}
