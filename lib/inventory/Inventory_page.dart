import 'package:flutter/material.dart';
import 'package:ptk_inventory/inventory/inventory_form.dart';

class InventoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InventoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded), onPressed: () {  },),
        title: const Text('Добавление'),
        centerTitle: true,
      ),
      body: InventoryForm(),
    );
  }
}
