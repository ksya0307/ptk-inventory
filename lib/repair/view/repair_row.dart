import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class Repair extends StatelessWidget {
  final int id;
  const Repair({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
                    "  widget.numberInClassroom",
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
                //  onTap: "widget.onTap",
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "widget.inventoryNumber",
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: blackLabels,
                          ),
                        ),
                        Text(
                          "widget.category",
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
        // if (!widget.last)
        //   const Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 12),
        //     child: Divider(
        //       color: greyDivider,
        //       thickness: .75,
        //     ),
        //   )
        // else
        //   const Padding(padding: EdgeInsets.only(bottom: 12)),
      ],
    );
  }
}
