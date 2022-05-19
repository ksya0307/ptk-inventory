import 'dart:core';

import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/provider/category_api_client.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';

enum CategoryStatus {
  created,
  notcreated,
  changed,
  unchanged,
  none,
  deleted,
  undeleted
}

class CategoryRepository {
  final CategoryProvider _categoryProvider;
  final AuthenticationRepository _authenticationRepository;
  CategoryRepository({
    CategoryProvider? categoryProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _categoryProvider = categoryProvider ?? CategoryProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<Category>> categories() async {
    try {
      final result = await _categoryProvider.allCategories(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on CategoriesRequestFailure {
      return [];
    } on CategoriesRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _categoryProvider.allCategories(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }

  Future<CategoryStatus> createCategory(
    GeneralModelRequest categoryModelRequest,
  ) async {
    try {
      await _categoryProvider.createCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryModelRequest.toMap(),
      );
      return CategoryStatus.created;
    } on CreateCategoryRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _categoryProvider.createCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryModelRequest.toMap(),
      );
      return CategoryStatus.created;
    } on CreateCategoryRequestFailure {
      return CategoryStatus.notcreated;
    }
  }

  Future<CategoryStatus> changeCategory(
    int categoryId,
    GeneralModelRequest updateCategory,
  ) async {
    try {
      await _categoryProvider.updateCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryId,
        updateCategory.toMap(),
      );
      return CategoryStatus.changed;
    } on ChangeCategoryRequestFailure {
      return CategoryStatus.unchanged;
    } on ChangeCategoryRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _categoryProvider.updateCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryId,
        updateCategory.toMap(),
      );
      return CategoryStatus.changed;
    }
  }

  Future<CategoryStatus> deleteCategory(int categoryId) async {
    try {
      await _categoryProvider.deleteCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryId,
      );
      return CategoryStatus.changed;
    } on DeleteCategoryRequestFailure {
      return CategoryStatus.unchanged;
    } on DeleteCategoryRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _categoryProvider.deleteCategory(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        categoryId,
      );
      return CategoryStatus.changed;
    }
  }
}
