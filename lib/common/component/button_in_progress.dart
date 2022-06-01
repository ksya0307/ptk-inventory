import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class InProgress extends StatelessWidget {
  const InProgress({
    Key? key,
    required this.inProgressText,
  }) : super(key: key);
  final String inProgressText;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: ElevatedButton.icon(
        onPressed: null,
        icon: const CircularProgressIndicator(color: primaryBlue),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromRGBO(0, 47, 167, 0.65);
            }
            return const Color.fromRGBO(0, 47, 167, 1.0);
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
          child: Text(
            inProgressText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(255, 255, 255, 0.65),
            ),
          ),
        ),
      ),
    );
  }
}
