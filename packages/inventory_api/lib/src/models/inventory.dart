import 'package:equipment_api/equipment_api_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory.g.dart';

@JsonSerializable()
class Inventory {
  final int id;
  final ClassroomEquipment inventory_number;
  final DateTime get_time;
  final String document;
  final String ifo;
  final Classroom for_classroom;
  final bool given;

  Inventory(
      {required this.id,
      required this.inventory_number,
      required this.get_time,
      required this.document,
      required this.ifo,
      required this.for_classroom,
      required this.given});

  factory Inventory.fromJson(Map<String, dynamic> json) => _$InventoryFromJson(json);
      // : id = json['id'],
      //   inventory_number =
      //       ClassroomEquipment.fromJson(json['inventory_number']),
      //   get_time = json['get_time'],
      //   document = json['document'],
      //   ifo = json['ifo'],
      //   for_classroom = Classroom.fromJson(json['for_classroom']),
      //   given = json['given'];

  Map<String, dynamic> toJson() => _$InventoryToJson(this);
      // {
      //   'id': id,
      //   'inventory_number': inventory_number.toJson(),
      //   'get_time': get_time,
      //   'document': document,
      //   'ifo': ifo,
      //   'for_classroom': for_classroom.toJson(),
      //   'given': given,
      // };
}
