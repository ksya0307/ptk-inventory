// Package imports:
import 'dart:async';

import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/change_password_request.dart';
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
      //  if the diffrence between the userHiveModel lastUpdate and now is greater than 15 min then call refreshToken()
      if (userHiveModel.lastTimeUpdated.difference(DateTime.now()).inMinutes >
          15) {
        await refreshToken(userHiveModel);
      }
      yield AuthenticationStatus.authenticated;
      yield* _controller.stream;
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
      print("Da $data");

      final userModel = await _userProvider.getUser(
        header: HeaderModel(token: data.accessToken).toMap(),
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        userId: data.userId,
      );
      final UserHiveModel userHiveModel = UserHiveModel(
        surname: userModel.surname,
        name: userModel.name,
        patronymic: userModel.patronymic,
        id: userModel.id,
        username: userModel.username,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
        lastTimeUpdated: DateTime.now(),
        userRole: userModel.role.userRoleToString,
      );
      await addUserProfile(userHiveModel: userHiveModel);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      print("inside catch");
      return LoginStatus.unverified;
    }
  }

  Future<void> refreshToken(UserHiveModel userHiveModel) async {
    try {
      final HeaderModel header = HeaderModel(token: userHiveModel.refreshToken);
      final data = await _userProvider.getNewPairOfTokens(header.toMap());
      await editUserProfile(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
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

  // Future<void> changePassword(ChangePasswordModelRequest changePasswordModelRequest) async {
  //   final data = await _userProvider.changePassword(header: header, )
  // }
}
