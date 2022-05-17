part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final FormzStatus formStatus;
  final Surname surname;
  final Name name;
  final Patronymic patronymic;
  final Username username;
  final Password password;

  const SignUpState({
    this.formStatus = FormzStatus.pure,
    this.surname = const Surname.pure(),
    this.name = const Name.pure(),
    this.patronymic = const Patronymic.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  @override
  List<Object> get props =>
      [formStatus, surname, name, patronymic, username, password];

  SignUpState copyWith({
    FormzStatus? formStatus,
    Surname? surname,
    Name? name,
    Patronymic? patronymic,
    Username? username,
    Password? password,
  }) {
    return SignUpState(
      formStatus: formStatus ?? this.formStatus,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
