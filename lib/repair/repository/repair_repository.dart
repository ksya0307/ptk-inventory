import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/repair/model/repair.dart';
import 'package:ptk_inventory/repair/model/repair_equipment.dart';
import 'package:ptk_inventory/repair/model/request/create_repair_equipment_request.dart';
import 'package:ptk_inventory/repair/model/request/create_repair_request.dart';
import 'package:ptk_inventory/repair/provider/repair_api_client.dart';

enum RepairStatus {
  created,
  notcreated,
  changed,
  unchanged,
  none,
  deleted,
  undeleted
}

class RepairRepository {
  final RepairProvider _repairProvider;
  final AuthenticationRepository _authenticationRepository;

  RepairRepository({
    RepairProvider? repairProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _repairProvider = repairProvider ?? RepairProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<RepairEquipment>> allRepairEquipment() async {
    try {
      final result = await _repairProvider.allRepairEquipment(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on AllEquipmentRepairFailure {
      return [];
    } on AllEquipmentRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _repairProvider.allRepairEquipment(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<Repair?> createRepair({
    required CreateRepairModelRequest repairModelRequest,
  }) async {
    try {
      final repair = await _repairProvider.createRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: repairModelRequest.toMap(),
      );

      return repair;
    } on CreateRepairFailure {
      return null;
    } on CreateRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final repair = await _repairProvider.createRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: repairModelRequest.toMap(),
      );

      return repair;
    }
  }

  Future<RepairStatus> createRepairEquipment({
    required CreateRepairEquipmentModelRequest
        createRepairEquipmentModelRequest,
  }) async {
    try {
      await _repairProvider.createRepairEquipment(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: CreateRepairEquipmentModelRequest(
          createRepairEquipmentModelRequest.repairId,
          createRepairEquipmentModelRequest.equipmentId,
          createRepairEquipmentModelRequest.problem,
        ).toMap(),
      );
      return RepairStatus.created;
    } on CreateRepairEquipmentFailure {
      return RepairStatus.notcreated;
    } on CreateRepairEquipmentUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _repairProvider.createRepairEquipment(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: CreateRepairEquipmentModelRequest(
          createRepairEquipmentModelRequest.repairId,
          createRepairEquipmentModelRequest.equipmentId,
          createRepairEquipmentModelRequest.problem,
        ).toMap(),
      );
      return RepairStatus.created;
    }
  }

  Future<List<Repair>> allRepair() async {
    try {
      final result = await _repairProvider.allRepairs(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on AllRepairFailure {
      return [];
    } on AllRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _repairProvider.allRepairs(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<RepairStatus> deleteRepair({required int repairId}) async {
    try {
      await _repairProvider.deleteRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repairId: repairId,
      );
      return RepairStatus.deleted;
    } on DeleteRepairFailure {
      return RepairStatus.undeleted;
    } on DeleteRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _repairProvider.deleteRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repairId: repairId,
      );
      return RepairStatus.deleted;
    }
  }

  Future<List<RepairEquipment>> userRepair() async {
    try {
      final result = await _repairProvider.userRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on UserRepairFailure {
      return [];
    } on UserRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _repairProvider.userRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<RepairStatus> changeRepair({
    required int repairId,
    required Repair repair,
  }) async {
    try {
      await _repairProvider.changeRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: repair.toMap(),
        repairId: repairId,
      );
      return RepairStatus.changed;
    } on ChangeRepairFailure {
      return RepairStatus.unchanged;
    } on ChangeRepairUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _repairProvider.changeRepair(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        repair: repair.toMap(),
        repairId: repairId,
      );
      return RepairStatus.changed;
    }
  }
}
