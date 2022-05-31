import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class ClassroomEquipmentRow extends StatelessWidget {
  final String numberInClassroom;
  final String inventoryNumber;
  final String category;
  final bool last;
  const ClassroomEquipmentRow(
      {Key? key,
      required this.numberInClassroom,
      required this.inventoryNumber,
      required this.category,
      required this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8 + 4,
                  bottom: 8 + 4,
                  left: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    numberInClassroom,
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
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inventoryNumber,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                        ),
                      ),
                      Text(
                        category,
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
          ],
        ),
        if (!last)
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
