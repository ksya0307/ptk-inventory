import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class ApplyFilterLabel extends StatelessWidget {
  const ApplyFilterLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          "Применить фильтр",
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: primaryBlue,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.keyboard_arrow_right_rounded,
          color: primaryBlue,
        )
      ],
    );
  }
}
