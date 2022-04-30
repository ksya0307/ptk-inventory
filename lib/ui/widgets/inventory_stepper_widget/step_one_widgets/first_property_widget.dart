import 'package:flutter/material.dart';

import 'package:ptk_inventory/ui/widgets/inventory_stepper_widget/step_one_widgets/choose_inventory_number_label_widget.dart';
import 'package:ptk_inventory/ui/widgets/inventory_stepper_widget/step_one_widgets/inventory_number.dart';

class FirtsProperty extends StatelessWidget {
  const FirtsProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [ChooseInventoryNumber(), InventoryNumber()],
    );
  }
}
