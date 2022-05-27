import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/common/property_label.dart';

class ChooseInventoryNumberLabel extends StatelessWidget {
  const ChooseInventoryNumberLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PropertyLabel(
            property: 'Выберите инвентарный номер',
            bottomPadding: 0,
          ),
          Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.rotationX(math.pi),
            child: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.shortcut_rounded,
                color: secondaryGreen,
              ),
            ),
          )
        ],
      ),
    );
  }
}