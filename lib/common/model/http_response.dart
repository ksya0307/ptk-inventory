import 'package:json_annotation/json_annotation.dart';

part 'http_response.g.dart';

enum ResponseStatus { success, failure }

@JsonSerializable()
class HttpResponse {
  int statusCode;
  String message;
  ResponseStatus responseStatus;
  HttpResponse(this.statusCode, this.message, this.responseStatus);

  factory HttpResponse.fromJson(Map<String, dynamic> json) =>
      _$HttpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HttpResponseToJson(this);
}
