import 'dart:core';

import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/provider/category_api_client.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/model/request/create_classroom_request.dart';
import 'package:ptk_inventory/classrooms/provider/classroom_api_client.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';

enum ClassroomStatus {
  created,
  notcreated,
  changed,
  unchanged,
  none,
  deleted,
  undeleted
}

class ClassroomRepository {
  final ClassroomProvider _classroomProvider;
  final AuthenticationRepository _authenticationRepository;
  ClassroomRepository({
    ClassroomProvider? classroomProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _classroomProvider = classroomProvider ?? ClassroomProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<Classroom>> classrooms() async {
    try {
      final result = await _classroomProvider.allClassrooms(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on ClassroomsRequestFailure {
      return [];
    } on ClassroomsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();

      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomProvider.allClassrooms(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );

      return result.result;
    }
  }

  Future<ClassroomStatus> createClassroom(
    CreateClassroomModelRequest classroomModelRequest,
  ) async {
    try {
      await _classroomProvider.createClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        classroomModelRequest.toMap(),
      );
      return ClassroomStatus.created;
    } on CreateClassroomRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _classroomProvider.createClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        classroomModelRequest.toMap(),
      );
      return ClassroomStatus.created;
    } on CreateClassroomRequestFailure {
      return ClassroomStatus.notcreated;
    }
  }

  Future<List<Classroom>> userClassrooms() async {
    try {
      final result = await _classroomProvider.userClassrooms(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on UserClassroomsRequestFailure {
      return [];
    } on UserClassroomsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();

      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomProvider.userClassrooms(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  // Future<ClassroomStatus> changeCategory(
  //   int categoryId,
  //   GeneralModelRequest updateCategory,
  // ) async {
  //   try {
  //     await _categoryProvider.updateCategory(
  //       HeaderModel(await HeaderModel.getAccessToken()).toMap(),
  //       categoryId,
  //       updateCategory.toMap(),
  //     );
  //     return ClassroomStatus.changed;
  //   } on ChangeCategoryRequestFailure {
  //     return ClassroomStatus.unchanged;
  //   } on ChangeCategoryRequestUnauthorized {
  //     final UserHiveModel? userHiveModel = await getUserProfile();
  //     if (userHiveModel != null) {
  //       await _authenticationRepository.refreshToken(userHiveModel);
  //     }
  //     await _categoryProvider.updateCategory(
  //       HeaderModel(await HeaderModel.getAccessToken()).toMap(),
  //       categoryId,
  //       updateCategory.toMap(),
  //     );
  //     return ClassroomStatus.changed;
  //   }
  // }

  Future<ClassroomStatus> deleteClassroom(String number) async {
    try {
      await _classroomProvider.deleteClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        number,
      );
      return ClassroomStatus.deleted;
    } on DeleteClassroomRequestFailure {
      return ClassroomStatus.undeleted;
    } on DeleteClassroomRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _classroomProvider.deleteClassroom(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        number,
      );
      return ClassroomStatus.deleted;
    }
  }
}
