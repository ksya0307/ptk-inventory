import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/category/model/category_result.dart';
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';

///Exception thrown when [allCategories] fails
class CategoriesRequestFailure implements Exception {}

///Exception thrown when [allCategories] unauthorized
class CategoriesRequestUnauthorized implements Exception {}

class CreateCategoryRequestFailure implements Exception {}

class CreateCategoryRequestUnauthorized implements Exception {}

class DeleteCategoryRequestFailure implements Exception {}

class DeleteCategoryRequestUnauthorized implements Exception {}

class ChangeCategoryRequestFailure implements Exception {}

class ChangeCategoryRequestUnauthorized implements Exception {}

class CategoryProvider {
  CategoryProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<CategoryResult> allCategories(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.categories,
    );

    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CategoriesRequestFailure;
    } else if (response.statusCode == 401) {
      throw CategoriesRequestUnauthorized();
    }

    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return CategoryResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> createCategory(
    Map<String, String> header,
    Map<String, dynamic> category,
  ) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.categories);
    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(category),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateCategoryRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateCategoryRequestUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> deleteCategory(
    Map<String, String> header,
    int categoryId,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.categories}?id=$categoryId",
    );
    final response = await _httpClient.delete(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteCategoryRequestFailure();
    } else if (response.statusCode == 401) {
      throw DeleteCategoryRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<GeneralModelResponse> updateCategory(
    Map<String, String> header,
    int categoryId,
    Map<String, dynamic> name,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.categories}?id=$categoryId",
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(name),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangeCategoryRequestFailure();
    } else if (response.statusCode == 401) {
      throw ChangeCategoryRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }
}
