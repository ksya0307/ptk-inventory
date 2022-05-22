part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  const NewPasswordState({
    this.formStatus = FormzStatus.pure,
    this.newPassword = const NewPassword.pure(),
  });

  final FormzStatus formStatus;
  final NewPassword newPassword;

  @override
  List<Object> get props => [formStatus, newPassword];

  NewPasswordState copyWith({
    FormzStatus? formStatus,
    NewPassword? newPassword,
  }) {
    return NewPasswordState(
      formStatus: formStatus ?? this.formStatus,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}

class NewPasswordInitial extends NewPasswordState {}
