import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';
import 'package:ptk_inventory/inventory/model/requests/create_comment_request.dart';
import 'package:ptk_inventory/inventory/model/requests/create_inventory_request.dart';
import 'package:ptk_inventory/inventory/provider/inventory_api_client.dart';

enum InventoryStatus {
  created,
  deleted,
  changed,
  notCreated,
  notChanged,
  notDeleted
}

class InventoryRepository {
  final AuthenticationRepository _authenticationRepository;
  final InventoryProvider _inventoryProvider;

  InventoryRepository({
    InventoryProvider? inventoryProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _inventoryProvider = inventoryProvider ?? InventoryProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<Inventory>> inventory() async {
    try {
      final result = await _inventoryProvider.inventory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on InventoryRequestFailure {
      return [];
    } on InventoryRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _inventoryProvider.inventory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<Inventory?> createInventory({
    required CreateInventoryModelRequest createInventoryModelRequest,
  }) async {
    try {
      final inventory = await _inventoryProvider.createInventory(
        createInventoryModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return inventory;
    } on CreateInventoryRequestFailure catch (e) {
      print(e);
      return null;
    } on CreateInventoryRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final inventory = await _inventoryProvider.createInventory(
        createInventoryModelRequest.toMap(),
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return inventory;
    }
  }

  Future<InventoryStatus> createComment({
    required CreateCommentModelRequest createCommentModelRequest,
  }) async {
    try {
      _inventoryProvider.createComment(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        createCommentModelRequest.toMap(),
      );
      return InventoryStatus.created;
    } on CreateCommentRequestFailure {
      return InventoryStatus.notCreated;
    } on CreateCommentRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      _inventoryProvider.createComment(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        createCommentModelRequest.toMap(),
      );
      return InventoryStatus.created;
    }
  }
}
