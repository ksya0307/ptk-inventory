import 'dart:core';

import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/provider/ifo_api_client.dart';

enum IfoStatus {
  created,
  notcreated,
  changed,
  unchanged,
  none,
  deleted,
  undeleted
}

class IfoRepository {
  final IfoProvider _ifoProvider;
  final AuthenticationRepository _authenticationRepository;
  IfoRepository({
    IfoProvider? ifoProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _ifoProvider = ifoProvider ?? IfoProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<Ifo>> ifos() async {
    try {
      final result = await _ifoProvider.allIfos(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on IfosRequestFailure {
      return [];
    } on IfosRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _ifoProvider.allIfos(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }

  Future<IfoStatus> createIfo(
    GeneralModelRequest categoryModelRequest,
  ) async {
    try {
      await _ifoProvider.createIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryModelRequest.toMap(),
      );
      return IfoStatus.created;
    } on CreateIfoRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _ifoProvider.createIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryModelRequest.toMap(),
      );
      return IfoStatus.created;
    } on CreateIfoRequestFailure {
      return IfoStatus.notcreated;
    }
  }

  Future<IfoStatus> changeIfo(
    int ifoId,
    GeneralModelRequest updateIfo,
  ) async {
    try {
      await _ifoProvider.updateIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        ifoId,
        updateIfo.toMap(),
      );
      return IfoStatus.changed;
    } on ChangeIfoRequestFailure {
      return IfoStatus.unchanged;
    } on ChangeIfoRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _ifoProvider.updateIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        ifoId,
        updateIfo.toMap(),
      );
      return IfoStatus.changed;
    }
  }

  Future<IfoStatus> deleteIfo(int ifoId) async {
    try {
      await _ifoProvider.deleteIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        ifoId,
      );
      return IfoStatus.deleted;
    } on DeleteIfoRequestFailure {
      return IfoStatus.undeleted;
    } on DeleteIfoRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _ifoProvider.deleteIfo(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        ifoId,
      );
      return IfoStatus.deleted;
    }
  }
}
