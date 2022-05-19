import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/model/name.dart';
import 'package:ptk_inventory/documents/repository/document_repository.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc({required DocumentRepository documentRepository})
      : _documentRepository = documentRepository,
        super(const DocumentState()) {}

  final DocumentRepository _documentRepository;
}
