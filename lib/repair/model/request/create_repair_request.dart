import 'package:intl/intl.dart';

class CreateRepairModelRequest {
  final String phone;
  final DateTime dateTime;

  CreateRepairModelRequest(
    this.phone,
    this.dateTime,
  );

  Map<String, dynamic> toMap() {
    //  print("TO MAP");
    //print(DateFormat('yyyy-MM-ddThh:mm:ss.SSSSSS').format(dateTime));
    return <String, dynamic>{
      'phone': '+7 $phone',
      'datetime': DateFormat('yyyy-MM-ddThh:mm:ss.SSSSSS').format(dateTime),
    };
  }

  CreateRepairModelRequest copyWith({
    String? phone,
    DateTime? dateTime,
  }) {
    return CreateRepairModelRequest(
      phone ?? this.phone,
      dateTime ?? this.dateTime,
    );
  }
}
