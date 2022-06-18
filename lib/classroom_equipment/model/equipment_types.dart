import 'package:json_annotation/json_annotation.dart';

enum EquipmentBelonging {
  @JsonValue("LAB")
  lab,
  @JsonValue("PROD")
  prod,
  @JsonValue("OTHER")
  other
}

extension EquipmentBelongingExtension on EquipmentBelonging {
  String get equipmentBelongingToString {
    switch (this) {
      case EquipmentBelonging.lab:
        return 'Учебно-лабораторное оборудование';
      case EquipmentBelonging.prod:
        return 'Учебно-производственное оборудование';
      case EquipmentBelonging.other:
        return 'Другое';
    }
  }
  String get typeToMap {
    switch (this) {
      case EquipmentBelonging.lab:
        return 'LAB';
      case EquipmentBelonging.prod:
        return 'PROD';
      case EquipmentBelonging.other:
        return 'OTHER';
    }
  }
}
