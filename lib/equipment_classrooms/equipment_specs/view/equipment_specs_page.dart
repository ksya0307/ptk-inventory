import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class EquipmentSpecsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => EquipmentSpecsPage(),
    );
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
        centerTitle: true,
        title: const Text(
          "Добавить описание",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 18,
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
                child: addSpecsForm(context),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget addSpecsForm(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      propertyLabel(),
      specsField(context),
      const AddSpecsButton(),
    ],
  );
}

Widget propertyLabel() {
  return const Padding(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Text(
      "Описание",
      style: TextStyle(
        color: blackLabels,
        fontSize: 18,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget specsField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Container(
      decoration: const BoxDecoration(
        color: greyCard,
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Theme(
        data: ThemeData(
          textSelectionTheme:
              const TextSelectionThemeData(selectionColor: blueCustom),
        ),
        child: TextFormField(
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            color: blackInput,
          ),
          decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: 'Rubik',
              color: greyDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
              top: 12,
            ),
            hintText: 'Начните писать',
          ),
          maxLength: 1000,
          maxLines: 5,
          cursorColor: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}

class AddSpecsButton extends StatelessWidget {
  const AddSpecsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(
              primaryBlue,
            ),
          ),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
            child: Text(
              "Добавить",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
