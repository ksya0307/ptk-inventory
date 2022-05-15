import 'package:flutter/material.dart';
import 'package:ptk_inventory/reader_user/view/landscape_home_page.dart';
import 'package:ptk_inventory/reader_user/view/portrait_home_page.dart';

class ReaderPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ReaderPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? PortraitReaderPage()
            : LandscapeReaderPage(),
      ),
    );
  }
}
