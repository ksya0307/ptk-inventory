part of 'new_password_bloc.dart';

abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();

  @override
  List<Object> get props => [];
}

class NewPasswordChanged extends NewPasswordEvent {
  final String newPassword;
  const NewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class NewPasswordSaved extends NewPasswordEvent {
  const NewPasswordSaved();
}
