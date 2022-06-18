import 'package:ptk_inventory/classroom_equipment/model/equipment_types.dart';

class CreateEquipmentModelRequest {
  int inventoryNumber;
  String? classroom;
  int equipment;
  String? numberInClassroom;
  EquipmentBelonging type;
  CreateEquipmentModelRequest({
    required this.inventoryNumber,
    this.classroom,
    required this.equipment,
     this.numberInClassroom,
    required this.type,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inventory_number': inventoryNumber,
      'classroom': classroom,
      'equipment':equipment,
      'number_in_classroom':numberInClassroom,
      'equipment_type':type.typeToMap
    };
  }
}
