import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class InventoryProperty extends StatelessWidget {

final  String property;
final  double paddingLeft;
final  double paddingBottom;
final  double fontSize;
final  FontWeight fontWeight;
  const InventoryProperty({
    required this.property,
    required this.paddingLeft,
    required this.paddingBottom,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, bottom: paddingBottom),
      child: Text(
        property,
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
