import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GivenToggle extends StatelessWidget {
  const GivenToggle({
    Key? key,
    this.onToggle,
  }) : super(key: key);
  final void Function(int?)? onToggle;
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      onToggle: onToggle,
      totalSwitches: 2,
      cornerRadius: 7,
      labels: const ['Нет', 'Да'],
      borderWidth: 2,
      borderColor: const [secondaryGreen],
      activeBgColor: const [secondaryGreen],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: greyDark,
    );
  }
}
