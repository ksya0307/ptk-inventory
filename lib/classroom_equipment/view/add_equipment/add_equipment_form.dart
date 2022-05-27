import 'package:flutter/material.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_button.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_specs_label.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/equipment_belongings_radio_buttons.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/internal_equipment_number_input.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/inventory_number_input.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/property_label.dart';


import 'package:ptk_inventory/config/colors.dart';

class AddEquipmentForm extends StatelessWidget {
  const AddEquipmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            propertyLabel(
              'Инвентарный номер',
              ' *',
              redCustom,
              FontWeight.w500,
              18,
            ),
            const InventoryNumberInput(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Divider(
                color: greyDivider,
                thickness: .75,
              ),
            ),
            propertyLabel(
              'Оборудование',
              ' — Необязательно',
              greyDark,
              FontWeight.w400,
              16,
            ),
            const SearchEquipmentSpecs(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [AddSpecsLabel()],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Divider(
                color: greyDivider,
                thickness: .75,
              ),
            ),
            propertyLabel(
              'Аудитория',
              ' — Необязательно',
              greyDark,
              FontWeight.w400,
              16,
            ),
            classroomsChips(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Divider(
                color: greyDivider,
                thickness: .75,
              ),
            ),
            propertyLabel(
              'Внутренний номер',
              ' — Необязательно',
              greyDark,
              FontWeight.w400,
              16,
            ),
            const InternalEquipmentNumberInput(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Divider(
                color: greyDivider,
                thickness: .75,
              ),
            ),
            propertyLabel(
              'Принадлежность оборудования',
              ' *',
              redCustom,
              FontWeight.w500,
              18,
            ),
            const EquipmentBelongingRadioButtons(),
            const AddEquipmentButton(),
          ],
        ),
      ),
    );
  }
}
