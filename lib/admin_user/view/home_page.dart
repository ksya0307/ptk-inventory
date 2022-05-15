import 'package:flutter/material.dart';
import 'package:ptk_inventory/admin_user/view/landscape_home_page.dart';
import 'package:ptk_inventory/admin_user/view/portrait_home_page.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class AdminPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AdminPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBgAdmin,
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? PortraitAdminPage()
            : LandscapeAdminPage(),
      ),
    );
  }
}
