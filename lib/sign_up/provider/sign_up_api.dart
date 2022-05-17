import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';
import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';
import 'package:ptk_inventory/sign_up/models/response/sign_up_response.dart';

class SignUpRequestFailure implements Exception {}

class SignUpProvider {
  SignUpProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<SignUpModelResponse> signUp(Map<String, dynamic> signUp) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.signUp);
    final response = await _httpClient.post(
      request,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(signUp),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic>? answer = response.asMap();
      throw SignUpRequestFailure;
    }
    return SignUpModelResponse(message: response.body);
  }
}
