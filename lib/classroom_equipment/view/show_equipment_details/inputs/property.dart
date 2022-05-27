import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class Property extends StatelessWidget {
  final String property;
  final int maxLines;
  final double screenConstraint;
  const Property({
    Key? key,
    required this.property,
    required this.maxLines,
    required this.screenConstraint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * screenConstraint),
      child: TextFormField(
        minLines: 1,
        maxLines: maxLines,
        initialValue: property,
        enabled: false,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          color: blackInput,
        ),
        decoration: const InputDecoration(
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: blueCustom, width: 2),
          ),
        ),
      ),
    );
  }
}
