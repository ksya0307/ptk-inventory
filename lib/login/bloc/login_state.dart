part of 'login_bloc.dart';



//содержит состояния state, username, password
class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;

  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? passwordShowed,

  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,

    ) ;
  }
  @override
  List<Object?> get props => [status, username, password];
}