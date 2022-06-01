import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class PropertyLabel extends StatelessWidget {
  final String property;
  final double bottomPadding;
  final double leftPadding;
  const PropertyLabel({
    Key? key,
    required this.property,
    required this.bottomPadding,
    this.leftPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, left: leftPadding),
      child: Text(
        property,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: blackLabels,
        ),
      ),
    );
  }
}
