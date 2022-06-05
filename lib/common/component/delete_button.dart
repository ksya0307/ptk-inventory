import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.bottomSheet,
  }) : super(key: key);
  final Widget bottomSheet;
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
          elevation: MaterialStateProperty.all(6),
          shadowColor: MaterialStateProperty.all(
            const Color.fromARGB(62, 97, 97, 97),
          ),
          backgroundColor: MaterialStateProperty.all(greyCard),
          foregroundColor: MaterialStateProperty.all(redCustom),
        ),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: bottomSheet,
              ),
            );
          },
        ),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
          child: Text(
            "Удалить",
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
