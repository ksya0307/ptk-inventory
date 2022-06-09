part of 'document_bloc.dart';

class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  const DocumentNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class DocumentLoadList extends DocumentEvent {
  const DocumentLoadList();
}

class DocumentSubmitted extends DocumentEvent {
  const DocumentSubmitted();
}

class DocumentSaved extends DocumentEvent {
  const DocumentSaved();
}

class DocumentSearch extends DocumentEvent {
  const DocumentSearch({
    required this.matchingWord,
  });
  final String matchingWord;
}

class DocumentDeleted extends DocumentEvent {
  final int id;
  const DocumentDeleted(this.id);
  @override
  List<Object> get props => [id];
}

class DocumentSelected extends DocumentEvent {
  final Document? selectedDocument;

  const DocumentSelected(this.selectedDocument);
}

class DocumentDeleteFromList extends DocumentEvent {
  final Document document;
  const DocumentDeleteFromList({required this.document});
  @override
  List<Object> get props => [document];
}

class DocumentAddToList extends DocumentEvent {
  final Document document;
  const DocumentAddToList({required this.document});
  @override
  List<Object> get props => [document];
}

class DocumentSaveToList extends DocumentEvent {
  final Document document;
  const DocumentSaveToList({required this.document});
  @override
  List<Object> get props => [document];
}
