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
  }

  final IfoRepository _ifoRepository;

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
        ),
      );
    } else {
      emit(
        state.copyWith(
          ifoLoadingStatus: IfoLoadingStatus.loadingFailed,
        ),
      );
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
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
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
          name: state.selectedIfo!.name,
        ),
      );
      if (waiting == IfoStatus.unchanged) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }
}
