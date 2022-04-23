import 'package:json_annotation/json_annotation.dart';
import 'package:equipment_api/equipment_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('Equipments', () {
    group('fromJson', () {
      test('throws CheckedFromJsonException', () {
        expect(
          () => ClassroomEquipment.fromJson(<String, dynamic>{
            "id": 1,
            "inventory_number": 101340003666,
            "classroom": {
              "number": "111",
              "user": {
                "id": 6,
                "surname": "Зотов",
                "name": "Андрей",
                "patronymic": "Станиславович"
              }
            },
            "equipment": {
              "id": 9,
              "description": "Samsung Galaxy А31",
              "category": {"id": 7, "name": "Смартфон"}
            },
            "number_in_classroom": "111-09",
            "equipment_type": "Учебно-производственное оборудование"
          }),
          throwsA(isA<EquipmentNotFoundFailure>()),
        );
      });
    });
  });
}
