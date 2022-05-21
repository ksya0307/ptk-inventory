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
        Align(
          alignment: Alignment.centerLeft,
          child: dropdownLabel(context, labelText: labelText),
        ),
        Container(
          decoration: BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.circular(7.0),
          ),
          // margin: EdgeInsets.only(top: designValues(context).mainAxisSpacing13),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    0.0145089285714286 * MediaQuery.of(context).size.height,
              ),
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
