import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/change_password_request.dart';
import 'package:ptk_inventory/common/model/requests/change_user_request.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';

enum UserStatus { changed, unchanged, deleted, notDeleted, exists, notExists }
enum SignUpStatus { signed, unsigned }

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

  Future<UserStatus> userChangePassword(
    ChangePasswordModelRequest changePasswordModelRequest,
  ) async {
    try {
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return UserStatus.changed;
    } on ChangePasswordUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _userProvider.changePassword(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changePasswordModelRequest.toMap(),
      );
      return UserStatus.changed;
    } on ChangePasswordFailure {
      return UserStatus.unchanged;
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

  Future<UserStatus> updateUser(
    ChangeUserModelRequest changeUserModelRequest,
  ) async {
    try {
      await _userProvider.changeUserData(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changeUserModelRequest.toMap(),
      );
      return UserStatus.changed;
    } on ChangeUserDataFailure {
      return UserStatus.unchanged;
    } on ChangeUserDataUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _userProvider.changeUserData(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        body: changeUserModelRequest.toMap(),
      );
      return UserStatus.changed;
    }
  }

  Future<UserStatus> deleteUser(int userId) async {
    try {
      await _userProvider.deleteUser(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        userId: userId,
      );
      return UserStatus.deleted;
    } on DeleteUserFailure {
      return UserStatus.notDeleted;
    } on DeleteUserUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _userProvider.deleteUser(
        header: HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        userId: userId,
      );
      return UserStatus.deleted;
    }
  }
}
