import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class PropertyLabel extends StatelessWidget {
  final String property;

  const PropertyLabel({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
