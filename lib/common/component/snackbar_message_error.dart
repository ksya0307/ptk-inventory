import "package:flutter/material.dart";

// Project imports:
import 'package:ptk_inventory/config/colors.dart';

ScaffoldFeatureController snackbarMessageError(
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
        children: [
          Padding(
            padding: EdgeInsets.zero,
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
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.zero,
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
