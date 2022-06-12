import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class RepairRow extends StatelessWidget {
  final String number;
  final String inventoryNumber;
  final String dateTime;
  final bool last;
  const RepairRow({
    Key? key,
    required this.number,
    required this.inventoryNumber,
    required this.dateTime,
    required this.last,
  }) : super(key: key);

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
                  left: 16,
                  right: 8,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    number,
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
              flex: 6,
              child: InkWell(
                //  onTap: "widget.onTap",
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
                          dateTime,
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
