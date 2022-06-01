import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/ifo/model/ifo_result.dart';

///Exception thrown when [allIfo] fails
class IfosRequestFailure implements Exception {}

///Exception thrown when [allIfo] unauthorized
class IfosRequestUnauthorized implements Exception {}

class CreateIfoRequestFailure implements Exception {}

class CreateIfoRequestUnauthorized implements Exception {}

class DeleteIfoRequestFailure implements Exception {}

class DeleteIfoRequestUnauthorized implements Exception {}

class ChangeIfoRequestFailure implements Exception {}

class ChangeIfoRequestUnauthorized implements Exception {}

class IfoProvider {
  IfoProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<IfoResult> allIfos(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.ifo,
    );

    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw IfosRequestFailure;
    } else if (response.statusCode == 401) {
      throw IfosRequestUnauthorized();
    }

    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return IfoResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> createIfo(
    Map<String, String> header,
    Map<String, dynamic> ifo,
  ) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.ifo);
    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(ifo),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateIfoRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateIfoRequestUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> deleteIfo(
    Map<String, String> header,
    int ifoId,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.ifo}/$ifoId",
    );
    final response = await _httpClient.delete(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteIfoRequestFailure();
    } else if (response.statusCode == 401) {
      throw DeleteIfoRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<GeneralModelResponse> updateIfo(
    Map<String, String> header,
    int ifoId,
    Map<String, dynamic> name,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.ifo}/$ifoId",
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(
        name,
      ),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangeIfoRequestFailure();
    } else if (response.statusCode == 401) {
      throw ChangeIfoRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }
}
