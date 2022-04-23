import 'package:flutter/material.dart';
import 'package:ptk_inventory/ui/widgets/inventory_stepper_widget/stepper_widget.dart';

class InventoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление'),
        centerTitle: true,
      ),
      body: InventoryAdd(),
      
    );
  }
}
