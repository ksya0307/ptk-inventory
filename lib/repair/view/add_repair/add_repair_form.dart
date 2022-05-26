import 'package:flutter/material.dart';
import 'package:ptk_inventory/repair/view/add_repair/choose_inventory_number_label.dart';

class AddRepairForm extends StatelessWidget {
  const AddRepairForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: const [
          ChooseInventoryNumberLabel(),
        ],
      ),
    );
  }
}
