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
  const DocumentDeleted();
}
