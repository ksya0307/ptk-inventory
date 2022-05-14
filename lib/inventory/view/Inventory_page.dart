import 'package:flutter/material.dart';
import 'package:ptk_inventory/inventory/view/inventory_form.dart';

class InventoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InventoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {},
        ),
        title: const Text('Добавление'),
        centerTitle: true,
      ),
      body: InventoryForm(),
    );
  }
}
