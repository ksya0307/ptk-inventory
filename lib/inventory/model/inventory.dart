
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';

part 'inventory.g.dart';

@JsonSerializable()
class Inventory extends Equatable {
  final int id;
  @JsonKey(name: "inventory_number")
  final ClassroomEquipment inventoryNumber;
  @JsonKey(name: "get_date")
  final DateTime getDate;
  final Document document;
  final Ifo ifo;
  @JsonKey(name: "for_classroom")
  final Classroom forClassroom;
  final bool given;
  @JsonKey(name:"by_request")
  final bool byRequest;
  const Inventory({
    required this.id,
    required this.inventoryNumber,
    required this.getDate,
    required this.document,
    required this.ifo,
    required this.forClassroom,
    required this.given,
    required this.byRequest,
  });

    @override
  List<Object?> get props => [id, inventoryNumber, getDate, document,ifo, forClassroom, given, byRequest];
  
    factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);

}
