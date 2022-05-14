import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/auth_response.dart';
import 'package:ptk_inventory/common/model/http_response.dart';
import 'package:ptk_inventory/common/model/user.dart';

extension ResponseExtension on http.Response? {
  Map<String, dynamic>? asMap() {
    if (this == null) {
      return null;
    }
    Map<String, dynamic> _responseMap = {};

    _responseMap['statusCode'] = this!.statusCode;
    return _responseMap;
  }
}

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

///Exception thrown when [changePassword] fails
class ChangePasswordFailure implements Exception {}

///Класс для создания http запросов
//Слой Data Provider, самый низший
class UserProvider {
  UserProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  ///Авторизация и получение токенов для дальнейшего доступа к данным
  Future<AuthResponse> signIn(Map<String, dynamic> login) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.login);
    final response = await _httpClient.post(
      request,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(login),
    );
    if (response.statusCode != 200) {
      print("R ${response.statusCode}");
      final Map<String, dynamic>? answer = response.asMap();
      throw LogInRequestFailure;
    }
    final Map<String, dynamic> jsonAnswer =
        jsonDecode(response.body) as Map<String, dynamic>;

    return AuthResponse.fromJson(jsonAnswer);
  }

  ///Получение [User] по заданному [user_id] и [accessToken]
  Future<User> getUser({
    required Map<String, String> header,
    required int userId,
    required String accessToken,
    required String refreshToken,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.users + userId.toString(),
    );
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200) {
      throw const GetUserRequestFailure("Get User Failed");
    } else {
      final Map<String, dynamic> userJson =
          jsonDecode(response.body) as Map<String, dynamic>;

      userJson["accessToken"] = accessToken;
      userJson["refreshToken"] = refreshToken;

      return User.fromJson(userJson);
    }
  }

  Future<AuthResponse> getNewPairOfTokens(Map<String, String> header) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.refresh);
    final response = await _httpClient.get(request, headers: header);

    if (response.statusCode != 200) {
      throw GetNewPairOfTokensFailure();
    } else {
      final Map<String, dynamic> jsonAnswer =
          jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(jsonAnswer);
    }
  }

  Future<HttpResponse> changePassword({
    required Map<String, String> header,
    required Map<String, dynamic> newPassword,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.changePassword,
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(newPassword),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonAnswer =
          jsonDecode(response.body) as Map<String, dynamic>;
      return HttpResponse.fromJson(jsonAnswer);
    } else {
      throw ChangePasswordFailure();
    }
  }
}
