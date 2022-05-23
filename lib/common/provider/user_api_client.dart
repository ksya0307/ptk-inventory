import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/auth_response.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/model/user_result.dart';

extension ResponseExtension on http.Response? {
  Map<String, dynamic>? asMap() {
    if (this == null) {
      return null;
    }
    final Map<String, dynamic> _responseMap = {};

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

///Exception thrown when [changePassword] unauthorized
class ChangePasswordUnauthorized implements Exception {}

///Exception thrown when [changeUserData] fails
class ChangeUserDataFailure implements Exception {}

///Exception thrown when [changeUserData] unauthorized
class ChangeUserDataUnauthorized implements Exception {}

///Exception thrown when [deleteUser] fails
class DeleteUserFailure implements Exception {}

///Exception thrown when [deleteUser] unauthorized
class DeleteUserUnauthorized implements Exception {}

///Exception thrown when [signUp] fails
class SignUpRequestFailure implements Exception {}

class ExistingUserFailure implements Exception {}

class ExistingUserUnauthorized implements Exception {}

class AllUsersFailure implements Exception {}

class AllUsersUnauthorized implements Exception {}

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
      //final Map<String, dynamic>? answer = response.asMap();
      throw LogInRequestFailure;
    }
    final Map<String, dynamic> jsonAnswer =
        jsonDecode(response.body) as Map<String, dynamic>;

    return AuthResponse.fromJson(jsonAnswer);
  }

  ///Получение [User] по заданному [user_id] и [accessToken]
  Future<User> getUser({
    required Map<String, String> header,
    required String accessToken,
    required String refreshToken,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.users,
    );
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200) {
      throw const GetUserRequestFailure("Get User Failed");
    }
    final Map<String, dynamic> userJson =
        jsonDecode(response.body) as Map<String, dynamic>;

    userJson["accessToken"] = accessToken;
    userJson["refreshToken"] = refreshToken;

    return User.fromJson(userJson);
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

  Future<GeneralModelResponse> changePassword({
    required Map<String, String> header,
    required Map<String, dynamic> body,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.users + ApiRoutes.changePassword,
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangePasswordFailure();
    } else if (response.statusCode == 401) {
      throw ChangePasswordUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> changeUserData({
    required Map<String, String> header,
    required Map<String, dynamic> body,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.users,
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangeUserDataFailure();
    } else if (response.statusCode == 401) {
      throw ChangeUserDataUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> deleteUser({
    required Map<String, String> header,
    required int userId,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.users}?id=$userId",
    );
    final response = await _httpClient.put(
      request,
      headers: header,
    );

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteUserFailure();
    } else if (response.statusCode == 401) {
      throw DeleteUserUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> signUp(Map<String, dynamic> signUp) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.signUp);
    final response = await _httpClient.post(
      request,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(signUp),
    );

    if (response.statusCode != 200) {
      //final Map<String, dynamic>? answer = response.asMap();
      throw SignUpRequestFailure;
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> existingUser({
    required Map<String, String> header,
    required int userId,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.users}${ApiRoutes.existingUser}/$userId",
    );
    final response = await _httpClient.get(request, headers: header);

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ExistingUserFailure();
    } else if (response.statusCode == 401) {
      throw ExistingUserUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<UserResult> allUsers({required Map<String, String> header}) async {
    final request = Uri.https(ApiRoutes.baseUrl,
        ApiRoutes.apiRoute + ApiRoutes.all + ApiRoutes.users);
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw AllUsersFailure();
    } else if (response.statusCode == 401) {
      throw AllUsersUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return UserResult.fromJson(jsonAnswer);
  }
}
