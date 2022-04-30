import 'package:hive_flutter/hive_flutter.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';

final Box<UserHiveModel> userHiveBox =
    Hive.box<UserHiveModel>('user_hive_model');

// get user profile
Future<UserHiveModel?> getUserProfile() async {
  if (userHiveBox.isNotEmpty) {
    return userHiveBox.getAt(0);
  }
  return null;
}

// add user profile
Future<bool?> addUserProfile({required UserHiveModel userHiveModel}) async {
  await userHiveBox.add(userHiveModel);
  return true;
}

// edit user profile
Future<bool?> editUserProfile({
  required String accessToken,
  required String refreshToken,
}) async {
  final userProfile = userHiveBox.get(0);
  if (userProfile != null) {
    final userHiveModel = UserHiveModel(
      surname: userProfile.surname,
      name: userProfile.name,
      patronymic: userProfile.patronymic,
      id: userProfile.id,
      username: userProfile.username,
      accessToken: accessToken,
      refreshToken: refreshToken,
      lastTimeUpdated: DateTime.now(),
      userRole: userProfile.userRole,
    );

    await userHiveBox.put(0, userHiveModel);
    return true;
  }
  return null;
}

Future<bool?> deleteUserProfile() async {
  await userHiveBox.clear();
  return true;
}
