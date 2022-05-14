part of 'login_bloc.dart';

//содержит состояния state, username, password
class LoginState extends Equatable {
  const LoginState({
    this.formStatus = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus formStatus;
  final Username username;
  final Password password;

  LoginState copyWith({
    FormzStatus? formStatus,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      formStatus: formStatus ?? this.formStatus,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        username,
        password,
      ];
}
