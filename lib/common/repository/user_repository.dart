import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/change_password_request.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';

enum ChangePasswordStatus { changed, unchanged }

class UserRepository {
  final UserProvider _userProvider;
  final AuthenticationRepository _authenticationRepository;
  UserRepository({
    UserProvider? userProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _userProvider = userProvider ?? UserProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<User?> getUser() async {
    final UserHiveModel? userHiveModel = await getUserProfile();

    if (userHiveModel != null) {
      return User.fromHiveToUser(userHiveModel);
    }
    return null;
  }

  Future<ChangePasswordStatus> userChangePassword(
    ChangePasswordModelRequest changePasswordModelRequest,
  ) async {
    try {
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return ChangePasswordStatus.changed;
    } on ChangePasswordUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return ChangePasswordStatus.changed;
    } on ChangePasswordFailure {
      return ChangePasswordStatus.unchanged;
    }
  }
}
