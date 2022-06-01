import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';
import 'package:ptk_inventory/users/models/name.dart';
import 'package:ptk_inventory/users/models/password.dart';
import 'package:ptk_inventory/users/models/surname.dart';
import 'package:ptk_inventory/users/models/username.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UsersState()) {
    on<UsersSurnameChanged>(_onSurnameChanged);
    on<UsersNameChanged>(_onNameChanged);
    on<UsersPatronymicChanged>(_onPatronymicChanged);
    on<UsersUsernameChanged>(_onUsernameChanged);
    on<UsersPasswordChanged>(_onPasswordChanged);
    on<UsersRoleChanged>(_onRoleChanged);

    on<UsersLoadList>(_onUsersLoadList);
    on<UsersAddToList>(_onAddToList);
    on<UsersSaveToList>(_onSaveToList);
    on<UsersDeleteFromList>(_onDeleteFromList);

    on<UsersDeleted>(_onDeleted);
    on<UsersSubmitted>(_onSubmitted);
    on<UsersSaved>(_onSaved);

    on<UsersSelected>(_onSelected);
    on<UsersSearch>(_onSearch);
  }

  final UserRepository _userRepository;

  void _onRoleChanged(
    UsersRoleChanged event,
    Emitter<UsersState> emit,
  ) {
    print("bloc role");
    print(event.role);
    emit(state.copyWith(role: event.role));
  }

  void _onDeleteFromList(
    UsersDeleteFromList event,
    Emitter<UsersState> emit,
  ) {
    final newList =
        state.globalUsers.where((user) => user != event.user).toList();

    emit(
      state.copyWith(
        userActionStatus: UserActionStatus.deletedFromGlobal,
        globalUsers: newList,
      ),
    );
    emit(state.copyWith(userActionStatus: UserActionStatus.pure));
  }

  void _onAddToList(
    UsersAddToList event,
    Emitter<UsersState> emit,
  ) {
    final newList =
        state.globalUsers.where((user) => user != event.user).toList();

    emit(
      state.copyWith(
        userActionStatus: UserActionStatus.addedToGlobal,
        globalUsers: newList,
      ),
    );
    emit(state.copyWith(userActionStatus: UserActionStatus.pure));
  }

  void _onSaveToList(
    UsersSaveToList event,
    Emitter<UsersState> emit,
  ) {
    // final Users user =
    //     Users(id: event.user.id, name: state.name.value);

    // final newList = state.globalCategories
    //     .where((user) => user != event.user)
    //     .toList();
    // final userIndex = state.globalCategories
    //     .indexWhere((element) => element.id == user.id);

    // newList[userIndex] = user;
    // print("user $user");
    // emit(
    //   state.copyWith(
    //     userActionStatus: UserActionStatus.savedOnGlobal,
    //     globalCategories: newList,
    //   ),
    // );
    // emit(state.copyWith(userActionStatus: UserActionStatus.pure));
  }

  void _onSelected(
    UsersSelected event,
    Emitter<UsersState> emit,
  ) {
    emit(state.copyWith(selectedUser: event.selectedUser));
  }

  void _onSearch(
    UsersSearch event,
    Emitter<UsersState> emit,
  ) {
    // filter from gloabl list where name contains event.matchingWord
    // and return that list to the state
    List<User> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalUsers
          .where(
            (user) => "${user.surname} ${user.name} ${user.patronymic}"
                .toLowerCase()
                .contains(event.matchingWord.toLowerCase()),
          )
          .toList();
    }

    emit(
      state.copyWith(
        visibleList: finalList,
        searchText: event.matchingWord,
      ),
    );
  }

  Future<void> _onDeleted(
    UsersDeleted event,
    Emitter<UsersState> emit,
  ) async {
    // emit(
    //   state.copyWith(
    //     userLoadingStatus: UserLoadingStatus.loadingInProgress,
    //   ),
    // );
    // final waiting =
    //     await _userRepository.deleteUsers(state.selectedUsers!.id);
    // print(waiting);
    // if (waiting == UsersStatus.deleted) {
    //   emit(
    //     state.copyWith(
    //       userLoadingStatus: UserLoadingStatus.loadingSuccess,
    //       userActionStatus: UserActionStatus.deleted,
    //     ),
    //   );
    //   emit(
    //     state.copyWith(
    //       userActionStatus: UserActionStatus.pure,
    //     ),
    //   );
    // } else {
    //   emit(
    //     state.copyWith(
    //       userLoadingStatus: UserLoadingStatus.loadingFailed,
    //       userActionStatus: UserActionStatus.notDeleted,
    //     ),
    //   );
    //   emit(
    //     state.copyWith(
    //       userActionStatus: UserActionStatus.pure,
    //     ),
    //   );
    // }
  }

  Future<void> _onUsersLoadList(
    UsersLoadList event,
    Emitter<UsersState> emit,
  ) async {
    emit(
      state.copyWith(
        userLoadingStatus: UserLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _userRepository.allUsers();
    if (waiting.isNotEmpty) {
      // filter the list by the accending id of the user
      waiting.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(
      state.copyWith(
        globalUsers: waiting,
        userLoadingStatus: UserLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onSurnameChanged(
    UsersSurnameChanged event,
    Emitter<UsersState> emit,
  ) {
    final surname = Surname.dirty(event.surname);
    emit(
      state.copyWith(
        surname: surname,
        formStatus: Formz.validate(
          [
            surname,
            state.name,
            state.username,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    UsersNameChanged event,
    Emitter<UsersState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        formStatus: Formz.validate(
          [
            state.surname,
            name,
            state.username,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onPatronymicChanged(
    UsersPatronymicChanged event,
    Emitter<UsersState> emit,
  ) {
    emit(
      state.copyWith(
        patronymic: event.patronymic,
        formStatus: Formz.validate(
          [
            state.surname,
            state.name,
            state.username,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onUsernameChanged(
    UsersUsernameChanged event,
    Emitter<UsersState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        formStatus: Formz.validate([
          state.surname,
          state.name,
          username,
          state.password,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    UsersPasswordChanged event,
    Emitter<UsersState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        formStatus: Formz.validate(
          [
            state.surname,
            state.name,
            state.username,
            password,
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    UsersSubmitted event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _userRepository.userSignUp(
        SignUpModelRequest(
          surname: state.surname.value,
          name: state.name.value,
          patronymic: state.patronymic,
          username: state.username.value,
          password: state.password.value,
          role: state.role.name,
        ),
      );
      if (waiting == SignUpStatus.unsigned) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            userActionStatus: UserActionStatus.notAdded,
          ),
        );
        emit(
          state.copyWith(
            userActionStatus: UserActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            userActionStatus: UserActionStatus.added,
          ),
        );
        emit(
          state.copyWith(
            userActionStatus: UserActionStatus.pure,
          ),
        );
      }
    }
  }

  Future<void> _onSaved(
    UsersSaved event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    // if (state.formStatus.isValidated) {
    //   final waiting = await _userRepository.changeUsers(
    //     state.selectedUsers!.id,
    //     GeneralModelRequest(name: state.name.value),
    //   );
    //   if (waiting == UsersStatus.unchanged) {
    //     emit(
    //       state.copyWith(
    //         formStatus: FormzStatus.submissionFailure,
    //         userActionStatus: UserActionStatus.notSaved,
    //       ),
    //     );
    //     emit(
    //       state.copyWith(
    //         userActionStatus: UserActionStatus.pure,
    //       ),
    //     );
    //   } else {
    //     emit(
    //       state.copyWith(
    //         formStatus: FormzStatus.submissionSuccess,
    //         userActionStatus: UserActionStatus.saved,
    //       ),
    //     );
    //     emit(
    //       state.copyWith(
    //         userActionStatus: UserActionStatus.pure,
    //       ),
    //     );
    //   }
    // }
  }
}
