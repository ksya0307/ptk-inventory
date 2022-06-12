import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/repair/model/repair.dart';
import 'package:ptk_inventory/repair/model/repair_equipment_result.dart';
import 'package:ptk_inventory/repair/model/repair_result.dart';

///Exception thrown when [createRepair] fails
class CreateRepairFailure implements Exception {}

///Exception thrown when [createRepair] unauthorized
class CreateRepairUnauthorized implements Exception {}

///Exception thrown when [allRepair] fails
class AllRepairFailure implements Exception {}

///Exception thrown when [allRepair] unauthorized
class AllRepairUnauthorized implements Exception {}

///Exception thrown when [allRepairEquipment] fails
class AllEquipmentRepairFailure implements Exception {}

///Exception thrown when [allRepairEquipment] unauthorized
class AllEquipmentRepairUnauthorized implements Exception {}

///Exception thrown when [deleteRepair] fails
class DeleteRepairFailure implements Exception {}

///Exception thrown when [deleteRepair] unauthorized
class DeleteRepairUnauthorized implements Exception {}

///Exception thrown when [userRepair] fails
class UserRepairFailure implements Exception {}

///Exception thrown when [userRepair] unauthorized
class UserRepairUnauthorized implements Exception {}

///Exception thrown when [createRepairEquipment] fails
class CreateRepairEquipmentFailure implements Exception {}

///Exception thrown when [createRepairEquipment] unauthorized
class CreateRepairEquipmentUnauthorized implements Exception {}

///Exception thrown when [changeRepair] fails
class ChangeRepairFailure implements Exception {}

///Exception thrown when [changeRepair] unauthorized
class ChangeRepairUnauthorized implements Exception {}

class RepairProvider {
  RepairProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<RepairEquipmentResult> allRepairEquipment({
    required Map<String, String> header,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.repairEquipment,
    );
    final response = await _httpClient.get(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw AllEquipmentRepairFailure();
    } else if (response.statusCode == 401) {
      throw AllEquipmentRepairUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return RepairEquipmentResult.fromJson(jsonAnswer);
  }

  Future<Repair> createRepair({
    required Map<String, String> header,
    required Map<String, dynamic> repair,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.repair,
    );

    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(repair),
    );

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateRepairFailure();
    } else if (response.statusCode == 401) {
      throw CreateRepairUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer =
        jsonDecode(response.body) as Map<String, dynamic>;
    jsonAnswer["repair"] = response.body;
    return Repair.fromJson(jsonAnswer);
  }

  Future<RepairResult> allRepairs({
    required Map<String, String> header,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.repair,
    );
    final response = await _httpClient.get(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw AllRepairFailure();
    } else if (response.statusCode == 401) {
      throw AllRepairUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return RepairResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> deleteRepair({
    required Map<String, String> header,
    required int repairId,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.repair}/$repairId",
    );

    final response = await _httpClient.delete(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteRepairFailure();
    } else if (response.statusCode == 401) {
      throw DeleteRepairUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<RepairEquipmentResult> userRepair({
    required Map<String, String> header,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.repairEquipment}/${ApiRoutes.userRepair}",
    );

    final response = await _httpClient.get(request, headers: header);
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw UserRepairFailure();
    } else if (response.statusCode == 401) {
      throw UserRepairUnauthorized();
    }
    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);

    return RepairEquipmentResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> changeRepair({
    required Map<String, String> header,
    required Map<String, dynamic> repair,
    required int repairId,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.repair}/$repairId",
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(repair),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangeRepairFailure();
    } else if (response.statusCode == 401) {
      throw ChangeRepairUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> createRepairEquipment({
    required Map<String, String> header,
    required Map<String, dynamic> repair,
  }) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.repairEquipment,
    );

    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(repair),
    );

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateRepairEquipmentFailure();
    } else if (response.statusCode == 401) {
      throw CreateRepairEquipmentUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }
}
