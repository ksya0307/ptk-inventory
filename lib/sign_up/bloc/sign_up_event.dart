part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSurnameChanged extends SignUpEvent {
  final String surname;

  const SignUpSurnameChanged(this.surname);

  @override
  List<Object> get props => [surname];
}

class SignUpNameChanged extends SignUpEvent {
  final String name;

  const SignUpNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class SignUpPatronymicChanged extends SignUpEvent {
  final String patronymic;

  const SignUpPatronymicChanged(this.patronymic);

  @override
  List<Object> get props => [patronymic];
}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  const SignUpUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}
