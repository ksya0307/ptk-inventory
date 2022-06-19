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
      'get_date': getDate.toIso8601String(),
      'document': document,
      'ifo': ifo,
      'for_classroom': forClassroom,
      'given': given,
      'by_request': byRequest,
    };
  }
}
