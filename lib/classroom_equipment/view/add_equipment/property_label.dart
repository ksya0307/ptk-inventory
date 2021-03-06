import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

Widget propertyLabel(
  String firstText,
  String secondText,
  Color secondTextColor,
  FontWeight fontWeightSecondText,
  double secondsTextSize,
) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: firstText,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackLabels,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextSpan(
          text: secondText,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: secondsTextSize,
            color: secondTextColor,
            fontWeight: fontWeightSecondText,
          ),
        )
      ],
    ),
  );
}
