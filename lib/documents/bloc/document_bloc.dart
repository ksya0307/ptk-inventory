import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/model/name.dart';
import 'package:ptk_inventory/documents/repository/document_repository.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository,
        super(const DocumentState()) {
    on<DocumentNameChanged>(_onNameChanged);
    on<DocumentLoadList>(_onDocumentLoadList);
    on<DocumentSubmitted>(_onSubmitted);
    on<DocumentSaved>(_onSaved);
    on<DocumentSearch>(_onSearch);
    on<DocumentDeleted>(_onDeleted);
    on<DocumentSelected>(_onSelected);
  }

  final DocumentRepository _documentRepository;

  void _onSelected(
    DocumentSelected event,
    Emitter<DocumentState> emit,
  ) {
    emit(state.copyWith(selectedDocument: event.selectedDocument));
  }

  Future<void> _onDeleted(
    DocumentDeleted event,
    Emitter<DocumentState> emit,
  ) async {
    emit(
      state.copyWith(
        documentLoadingStatus: DocumentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting =
        await _documentRepository.deleteDocument(state.selectedDocument!.id);
    if (waiting == DocumentStatus.deleted) {
      emit(
        state.copyWith(
          documentLoadingStatus: DocumentLoadingStatus.loadingSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          documentLoadingStatus: DocumentLoadingStatus.loadingFailed,
        ),
      );
    }
  }

  void _onSearch(
    DocumentSearch event,
    Emitter<DocumentState> emit,
  ) {
    final filteredList = state.globalDocuments
        .where((document) => document.name.contains(event.matchingWord))
        .toList();
    emit(
      state.copyWith(
        visibleList: filteredList,
      ),
    );
  }

  Future<void> _onDocumentLoadList(
    DocumentLoadList event,
    Emitter<DocumentState> emit,
  ) async {
    emit(
      state.copyWith(
        documentLoadingStatus: DocumentLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _documentRepository.documents();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(
      state.copyWith(
        globalDocuments: waiting,
        documentLoadingStatus: DocumentLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onNameChanged(
    DocumentNameChanged event,
    Emitter<DocumentState> emit,
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
    DocumentSubmitted event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _documentRepository.createDocument(
        GeneralModelRequest(name: state.name.value),
      );
      if (waiting == DocumentStatus.notcreated) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }

  Future<void> _onSaved(
    DocumentSaved event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _documentRepository.changeDocument(
        state.selectedDocument!.id,
        GeneralModelRequest(
          name: state.selectedDocument!.name,
        ),
      );
      if (waiting == DocumentStatus.unchanged) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }
}
