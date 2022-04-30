part of 'login_bloc.dart';

enum LoginStatus { initial, verified, unverified }

//содержит состояния state, username, password
class LoginState extends Equatable {
  const LoginState({
    this.formStatus = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.screenStatus = LoginStatus.initial,
  });

  final FormzStatus formStatus;
  final Username username;
  final Password password;
  final LoginStatus screenStatus;

  LoginState copyWith({
    FormzStatus? formStatus,
    Username? username,
    Password? password,
    LoginStatus? screenStatus,
  }) {
    return LoginState(
      formStatus: formStatus ?? this.formStatus,
      username: username ?? this.username,
      password: password ?? this.password,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [formStatus, username, password, screenStatus];
}
