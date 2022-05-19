import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';

class SignUpRequestFailure implements Exception {}

class SignUpProvider {
  SignUpProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<GeneralModelResponse> signUp(Map<String, dynamic> signUp) async {
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
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }
}
