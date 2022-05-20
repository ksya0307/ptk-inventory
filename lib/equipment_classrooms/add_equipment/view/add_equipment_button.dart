import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class AddEquipmentButton extends StatelessWidget {
  const AddEquipmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
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
            backgroundColor: MaterialStateProperty.all(
              primaryBlue,
            ),
          ),
          onPressed: () {},
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
      ),
    );
  }
}
