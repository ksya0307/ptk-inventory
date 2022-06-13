import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment_result.dart';
import 'package:ptk_inventory/common/model/api_routes.dart';

///Exception thrown when [equipmentInUserClassroom] fails
class EquipmentInUserClassroomRequestFailure implements Exception {}

///Exception thrown when [equipmentInUserClassroom] unauthorized
class EquipmentInUserClassroomRequestUnauthorized implements Exception {}

///Exception thrown when [equipmentInChoosenClassroom] fails
class EquipmentInChoosenClassroomRequestFailure implements Exception {}

///Exception thrown when [equipmentInChoosenClassroom] unauthorized
class EquipmentInChoosenClassroomRequestUnauthorized implements Exception {}

class ClassroomEquipmentProvider {
  final http.Client _httpClient;

  ClassroomEquipmentProvider({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<ClassroomEquipmentResult> equipmentInUserClassroom(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.classroomEquipment}/${ApiRoutes.equipmentInUserClassroom}",
    );
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw EquipmentInUserClassroomRequestFailure();
    } else if (response.statusCode == 401) {
      throw EquipmentInUserClassroomRequestUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return ClassroomEquipmentResult.fromJson(jsonAnswer);
  }

  Future<ClassroomEquipmentResult> equipmentInChoosenClassroom(
    Map<String, String> header,
    String classroom,
  ) async {
    final request = Uri.https(
        ApiRoutes.baseUrl,
        "${ApiRoutes.apiRoute}${ApiRoutes.classroomEquipment}",
        {'classroom': classroom});
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw EquipmentInChoosenClassroomRequestFailure();
    } else if (response.statusCode == 401) {
      throw EquipmentInChoosenClassroomRequestUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return ClassroomEquipmentResult.fromJson(jsonAnswer);
  }
}
