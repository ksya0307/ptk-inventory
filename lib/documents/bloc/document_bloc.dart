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

    on<DocumentDeleteFromList>(_onDeleteFromList);
    on<DocumentAddToList>(_onAddToList);
    on<DocumentSaveToList>(_onSaveToList);
  }

  final DocumentRepository _documentRepository;

  void _onSaveToList(
    DocumentSaveToList event,
    Emitter<DocumentState> emit,
  ) {
    final Document document = Document(
      id: event.document.id,
      name: state.name.value.isEmpty
          ? state.selectedDocument!.name
          : state.name.value,
    );

    final newList = state.globalDocuments;
    final ifoIndex = state.globalDocuments
        .indexWhere((element) => element.id == document.id);

    newList[ifoIndex] = document;
    newList.sort((a, b) => a.name.compareTo(b.name));
    emit(
      state.copyWith(
        documentActionStatus: DocumentActionStatus.savedOnGlobal,
        globalDocuments: newList,
      ),
    );
    emit(state.copyWith(documentActionStatus: DocumentActionStatus.pure));
  }

  void _onAddToList(
    DocumentAddToList event,
    Emitter<DocumentState> emit,
  ) {}

  void _onDeleteFromList(
    DocumentDeleteFromList event,
    Emitter<DocumentState> emit,
  ) {
    final newList = state.globalDocuments
        .where((document) => document != event.document)
        .toList();

    emit(
      state.copyWith(
        documentActionStatus: DocumentActionStatus.deletedFromGlobal,
        globalDocuments: newList,
      ),
    );
    emit(state.copyWith(documentActionStatus: DocumentActionStatus.pure));
  }

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
          documentActionStatus: DocumentActionStatus.deleted,
        ),
      );
      emit(state.copyWith(documentActionStatus: DocumentActionStatus.pure));
    } else {
      emit(
        state.copyWith(
          documentLoadingStatus: DocumentLoadingStatus.loadingFailed,
          documentActionStatus: DocumentActionStatus.notDeleted,
        ),
      );
      emit(state.copyWith(documentActionStatus: DocumentActionStatus.pure));
    }
  }

  void _onSearch(
    DocumentSearch event,
    Emitter<DocumentState> emit,
  ) {
    List<Document> finalList = [];
    if (event.matchingWord.isNotEmpty) {
      finalList = state.globalDocuments
          .where(
            (document) => document.name
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
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            documentActionStatus: DocumentActionStatus.notAdded,
          ),
        );
        emit(
          state.copyWith(
            documentActionStatus: DocumentActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            documentActionStatus: DocumentActionStatus.added,
          ),
        );
        emit(
          state.copyWith(
            documentActionStatus: DocumentActionStatus.pure,
          ),
        );
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
          name: state.name.value,
        ),
      );
      if (waiting == DocumentStatus.unchanged) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            documentActionStatus: DocumentActionStatus.notSaved,
          ),
        );
        emit(
          state.copyWith(
            documentActionStatus: DocumentActionStatus.pure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
            documentActionStatus: DocumentActionStatus.saved,
          ),
        );
        emit(
          state.copyWith(
            documentActionStatus: DocumentActionStatus.pure,
          ),
        );
      }
    }
  }
}
