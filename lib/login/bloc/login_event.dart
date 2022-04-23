part of 'login_bloc.dart';

//будет 3 события
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
///событие, которое говорит bloc что username был изменен
class LoginUsernameChanged extends LoginEvent{
  final String username;

  const LoginUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}
///событие, которое говорит bloc что password был изменен
class LoginPasswordChanged extends LoginEvent{
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

///говорит bloc что форма подтверждена
class LoginSubmitted extends LoginEvent{
  const LoginSubmitted();
}

