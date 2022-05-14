part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  const NewPasswordState({
    this.formStatus = FormzStatus.pure,
    this.password = const Password.pure(),
  });

  final FormzStatus formStatus;
  final Password password;

  @override
  List<Object> get props => [];

  NewPasswordState copyWith({
    FormzStatus? formStatus,
    Password? password,
  }) {
    return NewPasswordState(
      formStatus: formStatus ?? this.formStatus,
      password: password ?? this.password,
    );
  }
}

class NewPasswordInitial extends NewPasswordState {}
