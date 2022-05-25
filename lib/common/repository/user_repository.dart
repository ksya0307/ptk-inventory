import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/change_password_request.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';

enum ChangeStatus { changed, unchanged }
enum SignUpStatus { signed, unsigned }
enum UsersStatus { successfullyGot, unsuccessfullyGot }

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

  Future<ChangeStatus> userChangePassword(
    ChangePasswordModelRequest changePasswordModelRequest,
  ) async {
    try {
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return ChangeStatus.changed;
    } on ChangePasswordUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return ChangeStatus.changed;
    } on ChangePasswordFailure {
      return ChangeStatus.unchanged;
    }
  }

  Future<SignUpStatus> userSignUp(
    SignUpModelRequest signUpModelRequest,
  ) async {
    try {
      await _userProvider.signUp(signUpModelRequest.toMap());
      return SignUpStatus.signed;
    } catch (e) {
      return SignUpStatus.unsigned;
    }
  }

  Future<List<User>> allUsers() async {
    try {
      final result = await _userProvider.allUsers(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on AllUsersFailure {
      return [];
    } on AllUsersUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _userProvider.allUsers(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    }
  }

  Future<void> updateUser() async {}
}
