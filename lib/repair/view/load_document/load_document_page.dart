import 'package:flutter/material.dart';
import 'package:ptk_inventory/repair/view/load_document/load_document_form.dart';
import 'package:ptk_inventory/teacher_user/view/home_page.dart';

class LoadDocumentPage extends StatelessWidget {
  const LoadDocumentPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoadDocumentPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Назад",
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(ReaderPage.route());
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Акт приема-передачи",
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
                  minHeight: view.minHeight,
                  minWidth: view.maxWidth,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LoadDocumentForm(),
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
