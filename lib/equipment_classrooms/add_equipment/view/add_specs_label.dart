import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/equipment_classrooms/equipment_specs/view/equipment_specs_page.dart';

class AddSpecsLabel extends StatelessWidget {
  const AddSpecsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(EquipmentSpecsPage.route()),
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
