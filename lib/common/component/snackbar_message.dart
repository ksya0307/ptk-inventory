import "package:flutter/material.dart";

// Project imports:
import 'package:ptk_inventory/config/theme/colors.dart';

ScaffoldFeatureController snackbarMessage(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 3000),
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: greyCard,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              message,
              style: const TextStyle(
                color: blackLabels,
                fontFamily: 'Rubik',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 0),
              child: Icon(
                Icons.close_rounded,
                color: primaryBlue,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
