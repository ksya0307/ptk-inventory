import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptk_inventory/common/model/api_routes.dart';
import 'package:ptk_inventory/common/model/responses/general_model_response.dart';
import 'package:ptk_inventory/documents/model/document_result.dart';

///Exception thrown when [allDocuments] fails
class DocumentsRequestFailure implements Exception {}

///Exception thrown when [allDocuments] unauthorized
class DocumentsRequestUnauthorized implements Exception {}

class CreateDocumentRequestFailure implements Exception {}

class CreateDocumentRequestUnauthorized implements Exception {}

class DeleteDocumentRequestFailure implements Exception {}

class DeleteDocumentRequestUnauthorized implements Exception {}

class ChangeDocumentRequestFailure implements Exception {}

class ChangeDocumentRequestUnauthorized implements Exception {}

class DocumentProvider {
  DocumentProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<DocumentResult> allDocuments(
    Map<String, String> header,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      ApiRoutes.apiRoute + ApiRoutes.documents,
    );
    final response = await _httpClient.get(request, headers: header);

    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DocumentsRequestFailure;
    } else if (response.statusCode == 401) {
      throw DocumentsRequestUnauthorized();
    }

    final Map<String, dynamic> jsonAnswer = {};
    jsonAnswer['result'] = jsonDecode(response.body);
    return DocumentResult.fromJson(jsonAnswer);
  }

  Future<GeneralModelResponse> createDocument(
    Map<String, String> header,
    Map<String, dynamic> document,
  ) async {
    final request =
        Uri.https(ApiRoutes.baseUrl, ApiRoutes.apiRoute + ApiRoutes.documents);
    final response = await _httpClient.post(
      request,
      headers: header,
      body: jsonEncode(document),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw CreateDocumentRequestFailure();
    } else if (response.statusCode == 401) {
      throw CreateDocumentRequestUnauthorized();
    }
    return GeneralModelResponse(
      response.body,
      response.statusCode,
    );
  }

  Future<GeneralModelResponse> deleteDocument(
    Map<String, String> header,
    int documentId,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.documents}/$documentId",
    );
    final response = await _httpClient.delete(
      request,
      headers: header,
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw DeleteDocumentRequestFailure();
    } else if (response.statusCode == 401) {
      throw DeleteDocumentRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }

  Future<GeneralModelResponse> updateDocument(
    Map<String, String> header,
    int documentId,
    Map<String, dynamic> name,
  ) async {
    final request = Uri.https(
      ApiRoutes.baseUrl,
      "${ApiRoutes.apiRoute}${ApiRoutes.documents}/$documentId",
    );
    final response = await _httpClient.put(
      request,
      headers: header,
      body: jsonEncode(name),
    );
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw ChangeDocumentRequestFailure();
    } else if (response.statusCode == 401) {
      throw ChangeDocumentRequestUnauthorized();
    }
    return GeneralModelResponse(response.body, response.statusCode);
  }
}
