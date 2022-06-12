import 'package:intl/intl.dart';

class CreateRepairModelRequest {
  final String phone;
  final DateTime dateTime;

  CreateRepairModelRequest(
    this.phone,
    this.dateTime,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': '+7 $phone',
      'datetime': DateFormat('yyyy-MM-dd').format(dateTime),
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
