import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class ShowAllLabel extends StatelessWidget {
  final String property;
  final double bottomPadding;
  final double rightPadding;
  const ShowAllLabel({
    Key? key,
    required this.property,
    required this.bottomPadding,
    this.rightPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, right: rightPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: blackLabels,
            ),
          ),
          const Icon(Icons.keyboard_arrow_right_rounded)
        ],
      ),
    );
  }
}
