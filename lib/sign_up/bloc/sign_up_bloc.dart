import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/sign_up/models/models.dart';
import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';
import 'package:ptk_inventory/sign_up/repository/sign_up_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(const SignUpState()) {
    on<SignUpSurnameChanged>(_onSurnameChanged);
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpPatronymicChanged>(_onPatronymicChanged);
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  final SignUpRepository _signUpRepository;

  void _onSurnameChanged(
    SignUpSurnameChanged event,
    Emitter<SignUpState> emit,
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
    SignUpNameChanged event,
    Emitter<SignUpState> emit,
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
    SignUpPatronymicChanged event,
    Emitter<SignUpState> emit,
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
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
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
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
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
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _signUpRepository.userSignUp(
        SignUpModelRequest(
          surname: state.surname.value,
          name: state.name.value,
          patronymic: state.patronymic,
          username: state.username.value,
          password: state.password.value,
        ),
      );
      if (waiting == SignUpStatus.unsigned) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }
}
