// import 'dart:async';
// import 'dart:convert';

// import 'package:equipment_api/equipment_api_client.dart';
// import 'package:http/http.dart' as http;


// ///Exception thrown when [getAllEquipment] fails
// class EquipmentRequestFailure implements Exception {}

// ///Exception thrown when [getAllEquipment] is not found
// class EquipmentNotFoundFailure implements Exception {}

// ///Exception thrown when [getEquipmentByClassroomOrCategory] fails
// class EquipmentByClassroomOrCategoryRequestFailure implements Exception {}

// ///Exception thrown when [getEquipmentByClassroomOrCategory] is not found
// class EquipmentByClassroomOrCategoryNotFoundFailure implements Exception {}

// ///Exception thrown when [getClassroomsByUserId] fails
// class ClassroomsByUserIdRequestFailure implements Exception {}

// ///Exception thrown when [getClassroomsByUserId] is not found
// class ClassroomsByUserIdNotFoundFailure implements Exception {}

// class EquipmentApiClient {
//   EquipmentApiClient({http.Client? httpClient})
//       : _httpClient = httpClient ?? http.Client();

//   final http.Client _httpClient;

//   static const _baseUrl = 'ktor-equipment-inventory.herokuapp.com';

//   ///Найти список [inventory_number] `/api/v1/classroom-equipment`
//   Future<ClassroomEquipment> getAllEquipment() async {
//     final request = Uri.https(_baseUrl, '/api/v1/classroom-equipment');
//     final response = await _httpClient.get(request);

//     if (response.statusCode != 200) {
//       throw EquipmentRequestFailure();
//     }

//     final equipmentJson = jsonDecode(
//       response.body,
//     ) as List;

//     if (equipmentJson.isEmpty) {
//       throw EquipmentNotFoundFailure();
//     }

//     return ClassroomEquipment.fromJson(
//         equipmentJson.first as Map<String, dynamic>);
//   }

//   ///Найти список [ClassroomEquipment] `/api/v1/classroom-equipment?classroom=[120]&equipment-category=[ПК]`
//   Future<ClassroomEquipment> getEquipmentByClassroomOrCategory(
//       String? classroom, String? equipment_category) async {
//     final request = Uri.https(_baseUrl, '/api/v1/classroom-equipment/',
//         {'classroom': classroom, 'name': equipment_category});
//     final response = await _httpClient.get(request);

//     if (response.statusCode != 200) {
//       throw EquipmentByClassroomOrCategoryRequestFailure();
//     }

//     final equipmentJson = jsonDecode(response.body) as List;

//     if (equipmentJson.isEmpty) {
//       throw EquipmentByClassroomOrCategoryNotFoundFailure();
//     }
//     return ClassroomEquipment.fromJson(
//         equipmentJson.first as Map<String, dynamic>);
//   }

//   ///Найти список [Classroom] по [User.id] `/api/v1/classrooms?user-id=2`
//   Future<Classroom> getClassroomsByUserId(int id) async {
//     final request =
//         Uri.https(_baseUrl, '/api/v1/classrooms', <String, int>{'id': id});
//     final response = await _httpClient.get(request);

//     if (response.statusCode != 200) {
//       throw ClassroomsByUserIdRequestFailure();
//     }

//     final classroomsJson = jsonDecode(
//       response.body,
//     ) as List;

//     if (classroomsJson.isEmpty) {
//       throw ClassroomsByUserIdNotFoundFailure();
//     }

//     return Classroom.fromJson(classroomsJson.first as Map<String, dynamic>);
//   }
// }
