import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';
import 'package:ptk_inventory/inventory/model/inventory_result.dart';

class InventoryRequestFailure implements Exception {}

class InventoryRequestUnauthorized implements Exception {}

class CreateInventoryRequestFailure implements Exception {}

class CreateInventoryRequestUnauthorized implements Exception {}

class InventoryProvider {
  final http.Client _httpClient;

  InventoryProvider({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<InventoryResult> inventory(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.inventory}",
    );
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw InventoryRequestFailure();
    } else if (response.statusCode == 401) {
      throw InventoryRequestUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return InventoryResult.fromJson(jsonAnswer);
  }

  Future<Inventory> createInventory(
    Map<String, dynamic> body,
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.inventory}",
    );

    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateInventoryRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateInventoryRequestUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer =
        jsonDecode(response.body) as Map<String, dynamic>;
    jsonAnswer["inventory"] = response.body;
    return Inventory.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> createComment(
    Map<String, String> header,
    Map<String, dynamic> body,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.comments}",
    );
    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateCommentRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateCommentRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }
}

class CreateCommentRequestFailure implements Exception {}

class CreateCommentRequestUnauthorized implements Exception {}
