import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class AddIfoPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddIfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    children: [
                      addIfoForm(),
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

Widget addIfoForm() {
  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ifoName(),
        const IfoName(),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: AddIfoButton(),
        )
      ],
    ),
  );
}

Widget ifoName() {
  return const Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      'Название',
      style: TextStyle(
        color: blackLabels,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    ),
  );
}

class IfoName extends StatefulWidget {
  const IfoName({Key? key}) : super(key: key);

  @override
  State<IfoName> createState() => IfoNameState();
}

class IfoNameState extends State<IfoName> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('addIfoForm_ifoInput_textField'),
      cursorColor: Theme.of(context).primaryColor,
      minLines: 1,
      style: const TextStyle(
        fontFamily: 'Rubik',
        fontSize: 18,
        color: blackInput,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
        errorStyle: const TextStyle(
          color: redCustom,
          fontFamily: 'Rubik',
        ),
        hintText: 'Грант А',
        contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
        hintStyle: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          color: greyDark,
        ),
        border: const OutlineInputBorder(),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: redCustom,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redCustom, width: 1.5),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: blueCustom,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: greyDark,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}

class AddIfoButton extends StatelessWidget {
  const AddIfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: ElevatedButton(
        key: const Key('addIfoForm_ifo_raisedButton'),
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
    );
  }
}
