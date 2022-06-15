import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/model/number.dart';
import 'package:ptk_inventory/classrooms/model/request/create_classroom_request.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/common/model/user.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  ClassroomBloc({required ClassroomRepository classroomRepository})
      : _classroomRepository = classroomRepository,
        super(const ClassroomState()) {
    on<ClassroomNumberChanged>(_onNameChanged);

    on<ClassroomSubmitted>(_onSubmitted);
    on<ClassroomSaved>(_onSaved);

    on<ClassroomSearch>(_onSearch);

    on<ClassroomDeleted>(_onDeleted);
    on<ClassroomSelected>(_onSelected);
    //  on<ClassroomChosen>(_onChosen);

    on<ClassroomDeleteFromList>(_onDeleteFromList);
    on<ClassroomAddToList>(_onAddToList);
    on<ClassroomSaveToList>(_onSaveToList);

    on<ClassroomLoadUserList>(_onUserClassroomList);
    on<ClassroomLoadList>(_onClassroomLoadList);
  }

  final ClassroomRepository _classroomRepository;

  Future<void> _onUserClassroomList(
    ClassroomLoadUserList event,
    Emitter<ClassroomState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomLoadingStatus: ClassroomLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomRepository.userClassrooms();
    if (waiting.isNotEmpty) {
      waiting.add(Classroom(number: "Все", user: state.user));
      waiting.sort((a, b) => b.number.compareTo(a.number));
    }
    emit(
      state.copyWith(
        globalClassrooms: waiting,
        classroomLoadingStatus: ClassroomLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onDeleteFromList(
    ClassroomDeleteFromList event,
    Emitter<ClassroomState> emit,
  ) {
    // final newList = state.
    //     .where((classroom) => classroom != event.classroom)
    //     .toList();
    // emit(
    //   state.copyWith(
    //     classroomActionStatus: ClassroomActionStatus.deletedFromGlobal,
    //     globalCategories: newList,
    //   ),
    // );
    // emit(state.copyWith(classroomActionStatus: ClassroomActionStatus.pure));
  }

  void _onAddToList(
    ClassroomAddToList event,
    Emitter<ClassroomState> emit,
  ) {
    final newList = state.globalClassrooms
        .where((classroom) => classroom != event.classroom)
        .toList();

    emit(
      state.copyWith(
        classroomActionStatus: ClassroomActionStatus.addedToGlobal,
        globalClassrooms: newList,
      ),
    );
    emit(state.copyWith(classroomActionStatus: ClassroomActionStatus.pure));
  }

  void _onSaveToList(
    ClassroomSaveToList event,
    Emitter<ClassroomState> emit,
  ) {
    final Classroom classroom =
        Classroom(number: event.classroom.number, user: state.user);

    final newList = state.globalClassrooms
        .where((classroom) => classroom != event.classroom)
        .toList();
    final classroomIndex = state.globalClassrooms
        .indexWhere((element) => element.number == classroom.number);

    newList[classroomIndex] = classroom;
    emit(
      state.copyWith(
        classroomActionStatus: ClassroomActionStatus.savedOnGlobal,
        globalClassrooms: newList,
      ),
    );
    emit(state.copyWith(classroomActionStatus: ClassroomActionStatus.pure));
  }

  void _onSelected(
    ClassroomSelected event,
    Emitter<ClassroomState> emit,
  ) {
    emit(state.copyWith(selectedClassroom: event.selectedClassroom));
  }

  void _onSearch(
    ClassroomSearch event,
    Emitter<ClassroomState> emit,
  ) {
    // filter from gloabl list where name contains event.matchingWord
    // and return that list to the state
    List<Classroom> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalClassrooms
          .where(
            (classroom) => classroom.number
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
    ClassroomDeleted event,
    Emitter<ClassroomState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomLoadingStatus: ClassroomLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomRepository
        .deleteClassroom(state.selectedClassroom!.number);
    if (waiting == ClassroomStatus.deleted) {
      emit(
        state.copyWith(
          classroomLoadingStatus: ClassroomLoadingStatus.loadingSuccess,
          classroomActionStatus: ClassroomActionStatus.deleted,
        ),
      );
      emit(
        state.copyWith(
          classroomActionStatus: ClassroomActionStatus.pure,
        ),
      );
    } else {
      emit(
        state.copyWith(
          classroomLoadingStatus: ClassroomLoadingStatus.loadingFailed,
          classroomActionStatus: ClassroomActionStatus.notDeleted,
        ),
      );
      emit(
        state.copyWith(
          classroomActionStatus: ClassroomActionStatus.pure,
        ),
      );
    }
  }

  Future<void> _onClassroomLoadList(
    ClassroomLoadList event,
    Emitter<ClassroomState> emit,
  ) async {
    emit(
      state.copyWith(
        classroomLoadingStatus: ClassroomLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _classroomRepository.classrooms();
    if (waiting.isNotEmpty) {
      // filter the list by the accending id of the classroom
      waiting.sort((a, b) => a.number.compareTo(b.number));
    }

    emit(
      state.copyWith(
        globalClassrooms: waiting,
        classroomLoadingStatus: ClassroomLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onNameChanged(
    ClassroomNumberChanged event,
    Emitter<ClassroomState> emit,
  ) {
    final number = Number.dirty(event.number);
    emit(
      state.copyWith(
        number: number,
        formStatus: Formz.validate(
          [number],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    ClassroomSubmitted event,
    Emitter<ClassroomState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _classroomRepository.createClassroom(
        CreateClassroomModelRequest(
          number: state.number.value,
          user: state.user.id,
        ),
      );
      if (waiting == ClassroomStatus.notcreated) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            classroomActionStatus: ClassroomActionStatus.notAdded,
          ),
        );
        emit(
          state.copyWith(
            classroomActionStatus: ClassroomActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            classroomActionStatus: ClassroomActionStatus.added,
          ),
        );
        emit(
          state.copyWith(
            classroomActionStatus: ClassroomActionStatus.pure,
          ),
        );
      }
    }
  }

  Future<void> _onSaved(
    ClassroomSaved event,
    Emitter<ClassroomState> emit,
  ) async {
    //   emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    //   if (state.formStatus.isValidated) {
    //     final waiting = await _classroomRepository.changeClassroom(
    //       state.selectedClassroom!.id,
    //       GeneralModelRequest(name: state.name.value),
    //     );
    //     if (waiting == ClassroomStatus.unchanged) {
    //       emit(
    //         state.copyWith(
    //           formStatus: FormzStatus.submissionFailure,
    //           classroomActionStatus: ClassroomActionStatus.notSaved,
    //         ),
    //       );
    //       emit(
    //         state.copyWith(
    //           classroomActionStatus: ClassroomActionStatus.pure,
    //         ),
    //       );
    //     } else {
    //       emit(
    //         state.copyWith(
    //           formStatus: FormzStatus.submissionSuccess,
    //           classroomActionStatus: ClassroomActionStatus.saved,
    //         ),
    //       );
    //       emit(
    //         state.copyWith(
    //           classroomActionStatus: ClassroomActionStatus.pure,
    //         ),
    //       );
    //     }
    //   }
  }
}
