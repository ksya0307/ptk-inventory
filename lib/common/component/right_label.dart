import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class RightLabel extends StatelessWidget {
  const RightLabel({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryBlue,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
