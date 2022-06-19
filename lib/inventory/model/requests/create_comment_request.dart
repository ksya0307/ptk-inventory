
import 'package:intl/intl.dart';

class CreateCommentModelRequest {
  String comment;
  int inventoryId;
  int userId;
  DateTime datetime;
  CreateCommentModelRequest({
    required this.comment,
    required this.inventoryId,
    required this.userId,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'inventoryId': inventoryId,
      'userId': userId,
      'datetime': DateFormat('yyyy-MM-ddThh:mm:ss.SSSSSS').format(datetime),
    };
  }
}
