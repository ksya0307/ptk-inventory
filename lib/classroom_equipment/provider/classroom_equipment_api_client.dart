import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment_result.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment_result.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/create_specs_request.dart';
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';

///Exception thrown when [equipmentInUserClassroom] fails
class EquipmentInUserClassroomRequestFailure implements Exception {}

///Exception thrown when [equipmentInUserClassroom] unauthorized
class EquipmentInUserClassroomRequestUnauthorized implements Exception {}

///Exception thrown when [equipmentInChoosenClassroom] fails
class EquipmentInChoosenClassroomRequestFailure implements Exception {}

///Exception thrown when [equipmentInChoosenClassroom] unauthorized
class EquipmentInChoosenClassroomRequestUnauthorized implements Exception {}

class AllEquipmentSpecsRequestFailure implements Exception {}

class AllEquipmentSpecsRequestUnauthorized implements Exception {}

class DeleteEquipmentSpecsRequestFailure implements Exception {}

class DeleteEquipmentSpecsRequestUnauthorized implements Exception {}

class CreateEquipmentSpecsRequestFailure implements Exception {}

class CreateEquipmentSpecsRequestUnauthorized implements Exception {}


class UpdateEquipmentSpecsRequestFailure implements Exception {}

class UpdateEquipmentSpecsRequestUnauthorized implements Exception {}

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

  Future<EquipmentResult> allEquipmentSpecs(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.equipment}",
    );
    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw AllEquipmentSpecsRequestFailure();
    } else if (response.statusCode == 401) {
      throw AllEquipmentSpecsRequestUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return EquipmentResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> deleteEquipmentSpecs(
      Map<String, String> header, int equipmentId) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.equipment}/$equipmentId",
    );
    final response = await _httpClient.delete(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteEquipmentSpecsRequestFailure();
    } else if (response.statusCode == 401) {
      throw DeleteEquipmentSpecsRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<GeneralModelResponse> createSpecs(
    Map<String, dynamic> body,
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.equipment}",
    );
    final response =
        await _httpClient.post(request, headers: header, body: body);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateEquipmentSpecsRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateEquipmentSpecsRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<GeneralModelResponse> updateSpecs(  Map<String, dynamic> body,
    Map<String, String> header,) async{
        final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.equipment}",
    );
    final response =
        await _httpClient.put(request, headers: header, body: body);
          if (response.statusCode != 200 && response.statusCode != 401) {
      throw UpdateEquipmentSpecsRequestFailure();
    } else if (response.statusCode == 401) {
      throw UpdateEquipmentSpecsRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
    }
    
}
