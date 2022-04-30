import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

import '../../login/bloc/login_bloc.dart';
import '../../user/cubit/user_cubit.dart';

part 'user_event.dart';

part 'user_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required UserRepository userRepository}): _userRepository = userRepository,
        super(const AuthenticationState.unauthenticated()) {
    on<UserStatusChanged>(_onUserChanged);
    // on<SignInRequested>(_LoginSubmitted);
  }

  final UserRepository _userRepository;

  // late final StreamSubscription<UserStatus> _userSubscription;

  // @override
  // Future<void> close() {
  //   _userRepository.dispose();
  //   _userSubscription.cancel();
  //   return super.close();
  // }

  void _onUserChanged(UserStatusChanged event, Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case UserStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case UserStatus.authenticated:
        final user = await _tryGetUser(
            event.user.accessToken, event.user.refreshToken, event.user.id);
        print('!!!!!!!!$user.surname');
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
    }
  }

  Future<User?> _tryGetUser(
      String accessToken, String refreshToken, int user_id) async {
    try {
      final user = await _userRepository.getUser(
          refreshToken: refreshToken,
          accessToken: accessToken,
          user_id: user_id);
      return user;
    } catch (_) {
      return null;
    }
  }
}
