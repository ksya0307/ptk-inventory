import 'package:intl/intl.dart';

class CreateInventoryModelRequest {
  int inventoryNumber;
  DateTime getDate;
  int document;
  int ifo;
  String forClassroom;
  bool given;
  bool byRequest;
  CreateInventoryModelRequest({
    required this.inventoryNumber,
    required this.getDate,
    required this.document,
    required this.ifo,
    required this.forClassroom,
    required this.given,
    required this.byRequest,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inventory_number': inventoryNumber,
      'get_date': DateFormat("yyyy-MM-dd").format(getDate),
      'document': document,
      'ifo': ifo,
      'for_classroom': forClassroom,
      'given': given,
      'by_request': byRequest,
    };
  }
}
