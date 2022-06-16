import 'dart:core';

import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/provider/document_api_client.dart';

enum DocumentStatus {
  created,
  notcreated,
  changed,
  unchanged,
  none,
  deleted,
  undeleted
}

class DocumentRepository {
  final DocumentProvider _documentProvider;
  final AuthenticationRepository _authenticationRepository;
  DocumentRepository({
    DocumentProvider? documentProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _documentProvider = documentProvider ?? DocumentProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<Document>> documents() async {
    try {
      final result = await _documentProvider.allDocuments(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
      );
      return result.result;
    } on DocumentsRequestFailure {
      return [];
    } on DocumentsRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _documentProvider.allDocuments(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }

  Future<DocumentStatus> createDocument(
    GeneralModelRequest generalModelRequest,
  ) async {
    try {
      await _documentProvider.createDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        generalModelRequest.toMap(),
      );
      return DocumentStatus.created;
    } on CreateDocumentRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _documentProvider.createDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        generalModelRequest.toMap(),
      );
      return DocumentStatus.created;
    } on CreateDocumentRequestFailure {
      return DocumentStatus.notcreated;
    }
  }

  Future<DocumentStatus> changeDocument(
    int documentId,
    GeneralModelRequest updateDocument,
  ) async {
    try {
      await _documentProvider.updateDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        documentId,
        updateDocument.toMap(),
      );
      return DocumentStatus.changed;
    } on ChangeDocumentRequestFailure {
      return DocumentStatus.unchanged;
    } on ChangeDocumentRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _documentProvider.updateDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        documentId,
        updateDocument.toMap(),
      );
      return DocumentStatus.changed;
    }
  }

  Future<DocumentStatus> deleteDocument(int documentId) async {
    try {
      await _documentProvider.deleteDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        documentId,
      );
      return DocumentStatus.deleted;
    } on DeleteDocumentRequestFailure {
      return DocumentStatus.undeleted;
    } on DeleteDocumentRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      await _documentProvider.deleteDocument(
        HeaderModel(await HeaderModel.getAccessToken()).toMap(),
        documentId,
      );
      return DocumentStatus.deleted;
    }
  }
}
