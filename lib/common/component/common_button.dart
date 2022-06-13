import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.formValidated,
    this.onPress,
    required this.buttonText,
    required this.fontSize,
  }) : super(key: key);
  final bool formValidated;
  final void Function()? onPress;
  final String buttonText;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromRGBO(255, 255, 255, 0.65);
            }
            return Colors.white;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromRGBO(0, 47, 167, 0.65);
            }
            return const Color.fromRGBO(0, 47, 167, 1.0);
          }),
        ),
        onPressed: formValidated ? onPress : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
