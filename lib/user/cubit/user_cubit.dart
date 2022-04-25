import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/user/models/user.dart';
import 'package:user_repository/user_repository.dart' show UserRepository;

part 'user_state.dart';

part 'user_cubit.g.dart';

class UserCubit extends HydratedCubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserState());

  Future<void> fetchUser(String username,String password) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final user = User.fromRepository(
          await _userRepository.getUser(username: username, password: password));
      emit(state.copyWith(
          status: UserStatus.success,
          user: user.copyWith(
              surname: user.surname,
              name: user.name,
              patronymic: user.patronymic,
              username: user.username), authenticationStatus:  AuthenticationStatus.authenticated));
    } on Exception {
      emit(state.copyWith(status: UserStatus.failure, authenticationStatus: AuthenticationStatus.unauthenticated));
    }
  }

  void logOut(){
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.unauthenticated));
  }

  @override
  UserState fromJson(Map<String, dynamic> json) => UserState.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserState state) => state.toJson();
}
