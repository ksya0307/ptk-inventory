import 'package:flutter/material.dart';
import 'package:ptk_inventory/ifo/view/add_ifo_page.dart';

class DocumentsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DocumentsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Документы",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      documentForm(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget documentForm(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () => Navigator.of(context).push(AddIfoPage.route()),
        child: const Text("documents"),
      )
    ],
  );
}
