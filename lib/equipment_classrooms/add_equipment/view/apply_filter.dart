import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class ApplyFilter extends StatelessWidget {
  const ApplyFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ConstrainedBox(
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
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryBlue),
          ),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
            child: Text(
              "Применить фильтр",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
