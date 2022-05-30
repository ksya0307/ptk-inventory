import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/classrooms/model/classroom_result.dart';
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';

///Exception thrown when [allClassrooms] fails
class ClassroomsRequestFailure implements Exception {}

///Exception thrown when [allClassrooms] unauthorized
class ClassroomsRequestUnauthorized implements Exception {}

class UserClassroomsRequestFailure implements Exception {}

class UserClassroomsRequestUnauthorized implements Exception {}

class DeleteClassroomRequestFailure implements Exception {}

class DeleteClassroomRequestUnauthorized implements Exception {}

class CreateClassroomRequestFailure implements Exception {}

class CreateClassroomRequestUnauthorized implements Exception {}

class ClassroomProvider {
  ClassroomProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<ClassroomResult> allClassrooms(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.classrooms,
    );

    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ClassroomsRequestFailure;
    } else if (response.statusCode == 401) {
      throw ClassroomsRequestUnauthorized();
    }

    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return ClassroomResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> createClassroom(
    Map<String, String> header,
    Map<String, dynamic> classroom,
  ) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.classrooms);
    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(classroom),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateClassroomRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateClassroomRequestUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> deleteClassroom(
    Map<String, String> header,
    String classroomNumber,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.classrooms}/$classroomNumber",
    );
    final response = await _httpClient.delete(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteClassroomRequestFailure();
    } else if (response.statusCode == 401) {
      throw DeleteClassroomRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<ClassroomResult> userClassrooms(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.classrooms}${ApiRoutes.userClassrooms}",
    );
    final response = await _httpClient.get(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw UserClassroomsRequestFailure();
    } else if (response.statusCode == 401) {
      throw UserClassroomsRequestUnauthorized();
    }

    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return ClassroomResult.fromJson(jsonAnswer);
  }
}
