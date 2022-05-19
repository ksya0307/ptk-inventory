import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/model/requests/change_password_request.dart';
import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/login/login.dart';
import 'package:ptk_inventory/user/models/new_password.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const NewPasswordState()) {
    on<NewPasswordChanged>(_onNewPasswordChanged);

    on<NewPasswordSaved>(_onNewPasswordSaved);
  }
  final UserRepository _userRepository;

  Future<void> _onNewPasswordSaved(
    NewPasswordSaved event,
    Emitter<NewPasswordState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      // final data = await getUserProfile();
      //  userId: data!.id,
      final waiting = await _userRepository.userChangePassword(
        ChangePasswordModelRequest(
          newPassword: state.newPassword.value,
        ),
      );
      if (waiting == ChangePasswordStatus.unchanged) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }

  void _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<NewPasswordState> emit,
  ) {
    final newPassword = NewPassword.dirty(event.newPassword);
    emit(
      state.copyWith(
        newPassword: newPassword,
        formStatus: Formz.validate([newPassword]),
      ),
    );
  }
}
