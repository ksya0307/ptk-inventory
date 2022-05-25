part of 'users_bloc.dart';

enum UserLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum UserActionStatus {
  pure,
  deleted,
  notDeleted,
  deletedFromGlobal,
  savedOnGlobal,
  saved,
  notSaved,
  added,
  notAdded,
  addedToGlobal,
}

class UsersState extends Equatable {
  final FormzStatus formStatus;
  final Surname surname;
  final Name name;
  final String? patronymic;
  final Username username;
  final Password password;
  final UserRole role;
  final User? selectedUser;
  final List<User> globalUsers;
  final List<User> visibleList;
  final UserLoadingStatus userLoadingStatus;
  final UserActionStatus userActionStatus;
  final String searchText;
  const UsersState({
    this.formStatus = FormzStatus.pure,
    this.surname = const Surname.pure(),
    this.name = const Name.pure(),
    this.patronymic,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.role = UserRole.common,
    this.selectedUser,
    this.globalUsers = const [],
    this.visibleList = const [],
    this.userLoadingStatus = UserLoadingStatus.pure,
    this.userActionStatus = UserActionStatus.pure,
    this.searchText = "",
  });

  @override
  List<Object?> get props {
    return [
      formStatus,
      surname,
      name,
      patronymic,
      username,
      password,
      role,
      selectedUser,
      globalUsers,
      visibleList,
      userLoadingStatus,
      userActionStatus,
      searchText,
    ];
  }

  UsersState copyWith({
    FormzStatus? formStatus,
    Surname? surname,
    Name? name,
    String? patronymic,
    Username? username,
    Password? password,
    UserRole? role,
    User? selectedUser,
    List<User>? globalUsers,
    List<User>? visibleList,
    UserLoadingStatus? userLoadingStatus,
    UserActionStatus? userActionStatus,
    String? searchText,
  }) {
    return UsersState(
      formStatus: formStatus ?? this.formStatus,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      selectedUser: selectedUser ?? this.selectedUser,
      globalUsers: globalUsers ?? this.globalUsers,
      visibleList: visibleList ?? this.visibleList,
      userLoadingStatus: userLoadingStatus ?? this.userLoadingStatus,
      userActionStatus: userActionStatus ?? this.userActionStatus,
      searchText: searchText ?? this.searchText,
    );
  }
}
