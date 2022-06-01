import 'package:flutter/material.dart';
import 'package:ptk_inventory/ifo/view/add_ifo/add_ifo_form.dart';

class AddIfoPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddIfoPage());
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
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Добавление ИФО",
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AddIfoForm(),
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
