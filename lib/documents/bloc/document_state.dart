part of 'document_bloc.dart';

enum DocumentLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class DocumentState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final DocumentLoadingStatus documentLoadingStatus;
  final Document? selectedDocument;
  final List<Document> globalDocuments;
  final List<Document> visibleList;
  const DocumentState({
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.documentLoadingStatus = DocumentLoadingStatus.pure,
    this.selectedDocument,
    this.globalDocuments = const [],
    this.visibleList = const [],
  });

  @override
  List<Object?> get props {
    return [
      formStatus,
      name,
      documentLoadingStatus,
      selectedDocument,
      globalDocuments,
      visibleList,
    ];
  }

  DocumentState copyWith({
    FormzStatus? formStatus,
    Name? name,
    DocumentLoadingStatus? documentLoadingStatus,
    Document? selectedDocument,
    List<Document>? globalDocuments,
    List<Document>? visibleList,
  }) {
    return DocumentState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      documentLoadingStatus:
          documentLoadingStatus ?? this.documentLoadingStatus,
      selectedDocument: selectedDocument ?? this.selectedDocument,
      globalDocuments: globalDocuments ?? this.globalDocuments,
      visibleList: visibleList ?? this.visibleList,
    );
  }
}
