import 'package:flutter/material.dart';

import 'choose_inventory_number_label_widget.dart';
import 'inventory_number.dart';

class FirtsProperty extends StatelessWidget {
  const FirtsProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ChooseInventoryNumber(), InventoryNumber()],
    );
  }
}
