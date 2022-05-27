import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

enum EquipmentBelonging { lab, prod, other }

class EquipmentBelongingRadioButtons extends StatefulWidget {
  const EquipmentBelongingRadioButtons({Key? key}) : super(key: key);

  @override
  State<EquipmentBelongingRadioButtons> createState() =>
      _EquipmentBelongingRadioButtonsState();
}

class _EquipmentBelongingRadioButtonsState
    extends State<EquipmentBelongingRadioButtons> {
  EquipmentBelonging? _belonging = EquipmentBelonging.lab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 16, 0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Учебно-лабораторное оборудование',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.lab,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Учебно-производственное оборудование',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.prod,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Другое',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.other,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
