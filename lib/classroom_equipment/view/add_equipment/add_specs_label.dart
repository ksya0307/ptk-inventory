import 'package:flutter/material.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment_specs_page.dart';

import 'package:ptk_inventory/config/colors.dart';

class AddSpecsLabel extends StatelessWidget {
  const AddSpecsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(AddEquipmentSpecsPage.route()),
      child: const Padding(
        padding: EdgeInsets.only(top: 8, right: 16),
        child: Text(
          "Добавить",
          style: TextStyle(
            color: primaryBlue,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
