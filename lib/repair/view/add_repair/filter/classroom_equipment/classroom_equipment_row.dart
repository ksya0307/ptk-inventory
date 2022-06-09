import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class ClassroomEquipmentRow extends StatefulWidget {
  final String numberInClassroom;
  final String inventoryNumber;
  final String category;
  final bool last;
  // final int value;
  // final int groupValue;
  // final Function(int?)? onChange;
  final Function() onTap;
  final Widget? radio;
  const ClassroomEquipmentRow({
    Key? key,
    required this.numberInClassroom,
    required this.inventoryNumber,
    required this.category,
    required this.last,
    // required this.value,
    // required this.groupValue,
    // required this.onChange,
    required this.onTap,
    this.radio,
  }) : super(key: key);

  @override
  State<ClassroomEquipmentRow> createState() => _ClassroomEquipmentRowState();
}

class _ClassroomEquipmentRowState extends State<ClassroomEquipmentRow> {
  @override
  Widget build(BuildContext context) {
    //print(widget.groupValue);
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8 + 4,
                  bottom: 8 + 4,
                  left: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Transform.scale(
                    scale: 1.2,
                    child: RadioTheme(
                      data: RadioThemeData(
                        fillColor: MaterialStateProperty.all(primaryBlue),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: widget.radio!,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8 + 4,
                  bottom: 8 + 4,
                  left: 16,
                  right: 8,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.numberInClassroom,
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: blackLabels,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: InkWell(
                onTap: widget.onTap,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.inventoryNumber,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: blackLabels,
                          ),
                        ),
                        Text(
                          widget.category,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: greyDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!widget.last)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          )
        else
          const Padding(padding: EdgeInsets.only(bottom: 12)),
      ],
    );
  }
}
