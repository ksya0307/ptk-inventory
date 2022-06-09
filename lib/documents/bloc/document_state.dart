part of 'document_bloc.dart';

enum DocumentLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum DocumentActionStatus {
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

class DocumentState extends Equatable {
  final DocumentActionStatus documentActionStatus;
  final FormzStatus formStatus;
  final Name name;
  final String searchText;
  final DocumentLoadingStatus documentLoadingStatus;
  final Document? selectedDocument;
  final List<Document> globalDocuments;
  final List<Document> visibleList;
  const DocumentState({
    this.documentActionStatus = DocumentActionStatus.pure,
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.documentLoadingStatus = DocumentLoadingStatus.pure,
    this.selectedDocument,
    this.globalDocuments = const [],
    this.visibleList = const [],
    this.searchText = "",
  });

  @override
  List<Object?> get props => [
        documentActionStatus,
        formStatus,
        name,
        documentLoadingStatus,
        selectedDocument,
        globalDocuments,
        visibleList,
        searchText
      ];

  DocumentState copyWith({
    DocumentActionStatus? documentActionStatus,
    FormzStatus? formStatus,
    Name? name,
    String? searchText,
    DocumentLoadingStatus? documentLoadingStatus,
    Document? selectedDocument,
    List<Document>? globalDocuments,
    List<Document>? visibleList,
  }) {
    return DocumentState(
      documentActionStatus: documentActionStatus ?? this.documentActionStatus,
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      searchText: searchText ?? this.searchText,
      documentLoadingStatus:
          documentLoadingStatus ?? this.documentLoadingStatus,
      selectedDocument: selectedDocument ?? this.selectedDocument,
      globalDocuments: globalDocuments ?? this.globalDocuments,
      visibleList: visibleList ?? this.visibleList,
    );
  }
}
