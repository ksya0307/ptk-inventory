import 'package:flutter/material.dart';

class AddCommonButton extends StatelessWidget {
  const AddCommonButton({
    Key? key,
    required this.formValidated,
    this.onPress,
  }) : super(key: key);
  final bool formValidated;
  final void Function()? onPress;
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
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
          child: Text(
            "Добавить",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
/*
ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: ElevatedButton.icon(
                  onPressed: null,
                  icon: const CircularProgressIndicator(color: primaryBlue),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
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
                  label: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
                    child: Text(
                      "Добавление...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 0.65),
                      ),
                    ),
                  ),
                ),
              )

              */