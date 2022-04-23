import 'package:flutter/material.dart';

import 'step_one_widgets/first_property_widget.dart';

class InventoryAdd extends StatefulWidget {
  const InventoryAdd({Key? key}) : super(key: key);

  @override
  _InventoryAddState createState() => _InventoryAddState();
}

class _InventoryAddState extends State<InventoryAdd> {
  @override
  Widget build(BuildContext context) {
    return Stepper(
        margin: EdgeInsets.all(0),
        elevation: 0,
        type: StepperType.horizontal,
        steps: <Step>[
          Step(
              isActive: true,
              title: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Оборудование',
                    style: TextStyle(
                        fontFamily: 'PT Sans Caption',
                        fontSize: 14,
                        color: Color.fromRGBO(37, 37, 37, 1.0))),
                TextSpan(
                    text: ' *',
                    style: TextStyle(
                        fontFamily: 'PT Sans Caption',
                        fontSize: 14,
                        color: Color.fromRGBO(227, 50, 69, 1.0)))
              ])),
              content: FirtsProperty()),
          Step(
              title: Text('Дополнительно',
                  style: TextStyle(
                      fontFamily: 'PT Sans Caption',
                      fontSize: 14,
                      color: Color.fromRGBO(37, 37, 37, 1.0))),
              content: Text('ds'))
        ]);
  }
}
