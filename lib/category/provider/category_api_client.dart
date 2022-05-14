import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';

class CategoriesRequestFailure implements Exception {
  final String message;
  CategoriesRequestFailure(this.message);
}

class CategoryProvider {
  CategoryProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  // Future<List<Category>> allCategories(
  //   int page,
  //   int size,
  //   String sortDirection,
  //   String sortByColumn,
  //   Map<String, String> header,
  // ) async {
  //   final request = Uri.https(
  //     ApiRoutes.baseUrl,
  //     "${ApiRoutes.apiRoute}${ApiRoutes.allCategories}?page=$page&size=$size&sortDirection=$sortDirection&sortByColumn=$sortByColumn",
  //   );
  //   final response = await _httpClient.get(request, headers: header);
  //   if (response.statusCode != 200) {
  //     final Map<String, dynamic>? answer = response.asMap();
  //     throw CategoriesRequestFailure;
  //   }
  //   final List jsonAnswer = json.decode(response.body);

  //   return List<Category>.fromJson(jsonAnswer);
  // }
}
