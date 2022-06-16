import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment_result.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/create_specs_request.dart';
import 'package:ptk_inventory/classroom_equipment/model/requests/update_specs_request.dart';
import 'package:ptk_inventory/classroom_equipment/provider/classroom_equipment_api_client.dart';
import 'package:ptk_inventory/classrooms/model/request/create_classroom_request.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';

enum EquipmentStatus {
  created,
  deleted,
  changed,
  notCreated,
  notChanged,
  notDeleted
}

class ClassroomEquipmentRepository {
  final ClassroomEquipmentProvider _classroomEquipmentProvider;
  final AuthenticationRepository _authenticationRepository;

  ClassroomEquipmentRepository({
    ClassroomEquipmentProvider? classroomEquipmentProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _classroomEquipmentProvider =
            classroomEquipmentProvider ?? ClassroomEquipmentProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<ClassroomEquipment>> userEquipments() async {
    try {
      final result = await _classroomEquipmentProvider.equipmentInUserClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on EquipmentInUserClassroomRequestFailure {
      return [];
    } on EquipmentInUserClassroomRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomEquipmentProvider.equipmentInUserClassroom(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }

  Future<List<ClassroomEquipment>> userChosenClassroomEquipment({
    required String classroom,
  }) async {
    try {
      final result =
          await _classroomEquipmentProvider.equipmentInChoosenClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        classroom,
      );
      return result.result;
    } on EquipmentInUserClassroomRequestFailure {
      return [];
    } on EquipmentInUserClassroomRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomEquipmentProvider.equipmentInUserClassroom(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }

  Future<List<Equipment>> allEquipment() async {
    try {
      final result = await _classroomEquipmentProvider.allEquipmentSpecs(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on AllEquipmentSpecsRequestFailure {
      return [];
    } on AllEquipmentSpecsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomEquipmentProvider.allEquipmentSpecs(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<EquipmentStatus> createEquipmentSpecs(
    CreateSpecsModelRequest createSpecsModelRequest,
  ) async {
    try {
      await _classroomEquipmentProvider.createSpecs(
        createSpecsModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return EquipmentStatus.created;
    } on CreateEquipmentSpecsRequestFailure {
      return EquipmentStatus.notCreated;
    } on CreateEquipmentSpecsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _classroomEquipmentProvider.createSpecs(
        createSpecsModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return EquipmentStatus.created;
    }
  }

  Future<EquipmentStatus> deleteEquipmentSpecs(
    int equipmentId,
  ) async {
    try {
      await _classroomEquipmentProvider.deleteEquipmentSpecs(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        equipmentId,
      );
      return EquipmentStatus.deleted;
    } on DeleteEquipmentSpecsRequestFailure {
      return EquipmentStatus.notDeleted;
    } on DeleteEquipmentSpecsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _classroomEquipmentProvider.deleteEquipmentSpecs(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        equipmentId,
      );
      return EquipmentStatus.deleted;
    }
  }

  Future<EquipmentStatus> updateEquipmentSpecs(
    UpdateSpecsModelRequest updateSpecsModelRequest,
  ) async {
    try {
      await _classroomEquipmentProvider.updateSpecs(
        updateSpecsModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return EquipmentStatus.changed;
    } on UpdateEquipmentSpecsRequestFailure {
      return EquipmentStatus.notChanged;
    } on UpdateEquipmentSpecsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _classroomEquipmentProvider.updateSpecs(
        updateSpecsModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return EquipmentStatus.changed;
    }
  }
}
