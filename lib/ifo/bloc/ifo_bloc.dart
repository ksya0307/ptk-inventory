import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/model/name.dart';
import 'package:ptk_inventory/ifo/repository/ifo_repository.dart';

part 'ifo_event.dart';
part 'ifo_state.dart';

class IfoBloc extends Bloc<IfoEvent, IfoState> {
  IfoBloc({required IfoRepository ifoRepository})
      : _ifoRepository = ifoRepository,
        super(const IfoState()) {
    on<IfoNameChanged>(_onNameChanged);
    on<IfoLoadList>(_onIfoLoadList);
    on<IfoSubmitted>(_onSubmitted);
    on<IfoSaved>(_onSaved);
    on<IfoSearch>(_onSearch);
    on<IfoDeleted>(_onDeleted);
    on<IfoSelected>(_onSelected);
    on<IfoDeleteFromList>(_onDeleteFromList);
    on<IfoAddToList>(_onAddToList);
    on<IfoSaveToList>(_onSaveList);
  }

  final IfoRepository _ifoRepository;

  void _onSaveList(
    IfoSaveToList event,
    Emitter<IfoState> emit,
  ) {
    final Ifo ifo = Ifo(id: event.ifo.id, name: state.name.value);

    final newList = state.globalIfos.where((ifo) => ifo != event.ifo).toList();
    final ifoIndex =
        state.globalIfos.indexWhere((element) => element.id == ifo.id);

    newList[ifoIndex] = ifo;
    emit(
      state.copyWith(
        ifoActionStatus: IfoActionStatus.savedOnGlobal,
        globalIfos: newList,
      ),
    );
    emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
  }

  void _onAddToList(
    IfoAddToList event,
    Emitter<IfoState> emit,
  ) {
    final newList = state.globalIfos.where((ifo) => ifo != event.ifo).toList();

    emit(
      state.copyWith(
        ifoActionStatus: IfoActionStatus.addedToGlobal,
        globalIfos: newList,
      ),
    );
    emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
  }

  void _onSelected(
    IfoSelected event,
    Emitter<IfoState> emit,
  ) {
    emit(state.copyWith(selectedIfo: event.selectedIfo));
  }

  void _onDeleteFromList(
    IfoDeleteFromList event,
    Emitter<IfoState> emit,
  ) {
    final newList = state.globalIfos.where((ifo) => ifo != event.ifo).toList();
    emit(
      state.copyWith(
        ifoActionStatus: IfoActionStatus.deletedFromGlobal,
        globalIfos: newList,
      ),
    );
    emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
  }

  Future<void> _onDeleted(
    IfoDeleted event,
    Emitter<IfoState> emit,
  ) async {
    emit(
      state.copyWith(
        ifoLoadingStatus: IfoLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _ifoRepository.deleteIfo(state.selectedIfo!.id);
    if (waiting == IfoStatus.deleted) {
      emit(
        state.copyWith(
          ifoLoadingStatus: IfoLoadingStatus.loadingSuccess,
          ifoActionStatus: IfoActionStatus.deleted,
        ),
      );
      emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
    } else {
      emit(
        state.copyWith(
          ifoLoadingStatus: IfoLoadingStatus.loadingFailed,
          ifoActionStatus: IfoActionStatus.notDeleted,
        ),
      );
      emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
    }
  }

  void _onSearch(
    IfoSearch event,
    Emitter<IfoState> emit,
  ) {
    final filteredList = state.globalIfos
        .where((ifo) => ifo.name.contains(event.matchingWord))
        .toList();
    emit(
      state.copyWith(
        visibleList: filteredList,
      ),
    );
  }

  Future<void> _onIfoLoadList(
    IfoLoadList event,
    Emitter<IfoState> emit,
  ) async {
    emit(
      state.copyWith(
        ifoLoadingStatus: IfoLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _ifoRepository.ifos();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(
      state.copyWith(
        globalIfos: waiting,
        ifoLoadingStatus: IfoLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onNameChanged(
    IfoNameChanged event,
    Emitter<IfoState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        formStatus: Formz.validate(
          [name],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    IfoSubmitted event,
    Emitter<IfoState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _ifoRepository.createIfo(
        GeneralModelRequest(name: state.name.value),
      );
      if (waiting == IfoStatus.notcreated) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            ifoActionStatus: IfoActionStatus.notAdded,
          ),
        );
        emit(
          state.copyWith(
            ifoActionStatus: IfoActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            ifoActionStatus: IfoActionStatus.added,
          ),
        );

        emit(
          state.copyWith(
            ifoActionStatus: IfoActionStatus.pure,
          ),
        );
      }
    }
  }

  Future<void> _onSaved(
    IfoSaved event,
    Emitter<IfoState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _ifoRepository.changeIfo(
        state.selectedIfo!.id,
        GeneralModelRequest(
          name: state.name.value,
        ),
      );
      if (waiting == IfoStatus.unchanged) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            ifoActionStatus: IfoActionStatus.notSaved,
          ),
        );
        emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            ifoActionStatus: IfoActionStatus.saved,
          ),
        );
        emit(state.copyWith(ifoActionStatus: IfoActionStatus.pure));
      }
    }
  }
}
