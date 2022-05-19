part of 'document_bloc.dart';

enum DocumentListStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class DocumentState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final DocumentListStatus documentListStatus;
  final Document? selectedDocument;
  final List<Document> globalDocuments;
  final List<Document> visibleList;
  const DocumentState({
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.documentListStatus = DocumentListStatus.pure,
    this.selectedDocument,
    this.globalDocuments = const [],
    this.visibleList = const [],
  });

  DocumentState copyWith({
    FormzStatus? formStatus,
    Name? name,
    DocumentListStatus? documentListStatus,
    Document? selectedDocument,
    List<Document>? globalDocuments,
    List<Document>? visibleList,
  }) {
    return DocumentState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      documentListStatus: documentListStatus ?? this.documentListStatus,
      selectedDocument: selectedDocument ?? this.selectedDocument,
      globalDocuments: globalDocuments ?? this.globalDocuments,
      visibleList: visibleList ?? this.visibleList,
    );
  }

  @override
  List<Object?> get props {
    return [
      formStatus,
      name,
      documentListStatus,
      selectedDocument,
      globalDocuments,
      visibleList,
    ];
  }
}
