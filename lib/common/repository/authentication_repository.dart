// Package imports:
import 'dart:async';

import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/login.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/provider/user_api_client.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
enum LoginStatus { verified, unverified }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>.broadcast();
  final _userProvider = UserProvider();

  // create a stream that for AuthenticationStatus
  Stream<AuthenticationStatus> get status async* {
    final UserHiveModel? userHiveModel = await getUserProfile();
    if (userHiveModel != null) {
      try {
        await _userProvider.existingUser(
          userId: userHiveModel.id,
        );
        //  print(result.statusCode);
      } on ExistingUserFailure {
        await logout();
      } on ExistingUserUnauthorized {
        await refreshToken(userHiveModel);
      }
      //  if the diffrence between the userHiveModel lastUpdate and now is greater than 15 min then call refreshToken()
      if (DateTime.now() ==
          DateTime.fromMillisecondsSinceEpoch(
            userHiveModel.accessTokenExpiredAt,
          )) {
        await refreshToken(userHiveModel);
      }
      yield AuthenticationStatus.authenticated;
      yield* _controller.stream;
      if (DateTime.now().millisecond > userHiveModel.refreshTokenExpiredAt) {
        yield AuthenticationStatus.unauthenticated;
        yield* _controller.stream;
      }
    } else {
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }
  }

  Future<LoginStatus?> login(
    LoginModelRequest loginModelRequest,
  ) async {
    try {
      final data = await _userProvider.signIn(loginModelRequest.toMap());

      final userModel = await _userProvider.getUser(
        header: HeaderModel(data.accessToken).toMap(),
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      final UserHiveModel userHiveModel = UserHiveModel(
        surname: userModel.surname,
        name: userModel.name,
        patronymic: userModel.patronymic,
        id: userModel.id,
        username: userModel.username,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        accessTokenExpiredAt: data.accessTokenExpiredAt,
        refreshTokenExpiredAt: data.refreshTokenExpiredAt,
        userRole: userModel.role.userRoleToString,
      );
      await addUserProfile(userHiveModel: userHiveModel);
      _controller.add(AuthenticationStatus.authenticated);
      return LoginStatus.verified;
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      return LoginStatus.unverified;
    }
  }

  Future<void> refreshToken(UserHiveModel userHiveModel) async {
    try {
      final HeaderModel header = HeaderModel(userHiveModel.refreshToken);

      final data = await _userProvider.getNewPairOfTokens(header.toMap());
      await editUserProfile(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        accessTokenExpiredAt: data.accessTokenExpiredAt,
        refreshTokenExpiredAt: data.refreshTokenExpiredAt,
      );
    } catch (_) {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  // delete user profile from hive box
  Future<void> logout() async {
    try {
      await deleteUserProfile();
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  // close the stream
  void dispose() => _controller.close();
}
