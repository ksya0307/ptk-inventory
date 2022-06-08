part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersSurnameChanged extends UsersEvent {
  final String surname;
  const UsersSurnameChanged(this.surname);
  @override
  List<Object> get props => [surname];
}

class UsersNameChanged extends UsersEvent {
  final String name;
  const UsersNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class UsersPatronymicChanged extends UsersEvent {
  final String patronymic;
  const UsersPatronymicChanged(this.patronymic);
  @override
  List<Object> get props => [patronymic];
}

class UsersUsernameChanged extends UsersEvent {
  final String username;
  const UsersUsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class UsersPasswordChanged extends UsersEvent {
  final String password;
  const UsersPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class UsersRoleChanged extends UsersEvent {
  final UserRole role;
  const UsersRoleChanged(this.role);
  @override
  List<Object> get props => [role];
}

class UsersLoadList extends UsersEvent {
  const UsersLoadList();
}

class UsersSubmitted extends UsersEvent {
  const UsersSubmitted();
}

class UsersSaved extends UsersEvent {
  const UsersSaved();
}

class UsersDeleted extends UsersEvent {
  final int id;
  const UsersDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class UsersSearch extends UsersEvent {
  final String matchingWord;
  const UsersSearch(this.matchingWord);
  @override
  List<Object> get props => [matchingWord];
}

class UsersSelected extends UsersEvent {
  final User? selectedUser;
  const UsersSelected(this.selectedUser);
}

class UsersDeleteFromList extends UsersEvent {
  final User user;
  const UsersDeleteFromList({required this.user});
  @override
  List<Object> get props => [user];
}

class UsersAddToList extends UsersEvent {
  final SignUpModelRequest user;
  const UsersAddToList({required this.user});
  @override
  List<Object> get props => [user];
}

class UsersSaveToList extends UsersEvent {
  final User user;
  const UsersSaveToList({required this.user});
  @override
  List<Object> get props => [user];
}
