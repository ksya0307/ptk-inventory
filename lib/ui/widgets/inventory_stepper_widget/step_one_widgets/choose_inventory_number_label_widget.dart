import 'package:flutter/material.dart';

class ChooseInventoryNumber extends StatelessWidget {
  const ChooseInventoryNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Выберите инвентарный номер',
      style: TextStyle(
          color: Color.fromRGBO(37, 37, 37, 1.0),
          fontFamily: 'PT Sans',
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}
