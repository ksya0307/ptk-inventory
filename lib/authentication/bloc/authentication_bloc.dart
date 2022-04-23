// import 'dart:async';
//
// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:ptk_inventory/user/models/user.dart';
// import 'package:user_repository/user_repository.dart';
//
// part 'authentication_event.dart';
// part 'authentication_state.dart';
//
// //отвечает за реагирование на изменения состояния
// //отправляет(emit) states на которые мы будем реагировать на presentation layer
// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//
//   final AuthenticationRepository _authenticationRepository;
//   final UserRepository _userRepository;
//   //объвление перед инициализацией
//   late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
//
//   AuthenticationBloc({
//     required AuthenticationRepository authenticationRepository,
//     required UserRepository userRepository}) :
//         _authenticationRepository = authenticationRepository,
//         _userRepository = userRepository,
//   super(const AuthenticationState.unknown()){
//
//     on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
//     on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
//     _authenticationStatusSubscription = _authenticationRepository.status.listen(
//             (status) => add(AuthenticationStatusChanged(status)),
//       );
//   }
//
//   @override
//   Future<void> close() {
//     _authenticationRepository.dispose();
//     _authenticationStatusSubscription.cancel();
//     return super.close();
//   }
//
//   void _onAuthenticationStatusChanged(
//       AuthenticationStatusChanged event,
//       Emitter<AuthenticationState> emit) async{
//     switch (event.status){
//       case AuthenticationStatus.unauthenticated:
//         return emit(const AuthenticationState.unauthenticated());
//       case AuthenticationStatus.authenticated:
//         final user = await _tryGetUser(state.user.username, state.user.p);
//         return emit(user != null
//             ? AuthenticationState.authenticated(user)
//             :const AuthenticationState.unauthenticated());
//       default:
//         return emit(const AuthenticationState.unknown());
//     }
//   }
//
//   void _onAuthenticationLogoutRequested(
//       AuthenticationLogoutRequested event,
//       Emitter<AuthenticationState> emit
//       ){
//     _authenticationRepository.logOut();
//   }
//
//
//   Future<User?> _tryGetUser(String username, String password) async{
//     try{
//       final user = await _userRepository.getUser(username, password);
//       return user;
//     }catch(_){
//       return null;
//     }
//   }
//
// }
