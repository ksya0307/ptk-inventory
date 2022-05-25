import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.dropDownWidget,
  }) : super(key: key);
  final String labelText;
  final Widget dropDownWidget;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          decoration: BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: dropDownWidget,
            ),
          ),
        ),
      ],
    );
  }
}

Text dropdownLabel(
  BuildContext context, {
  required String labelText,
}) {
  return Text(
    labelText,
    style:
        const TextStyle(fontFamily: 'Rubik', fontSize: 18, color: blackInput),
  );
}
