import 'package:flutter/material.dart';
import 'package:ptk_inventory/inventory/view/Inventory_page.dart';
import 'package:ptk_inventory/moderator_user/view/landscape_home_page.dart';
import 'package:ptk_inventory/moderator_user/view/portrait_home_page.dart';

class ModeratorPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ModeratorPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(InventoryPage.route()),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? PortraitModeratorPage()
            : LandscapeModeratorPage(),
      ),
    );
  }
}
