import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class InventoryRow extends StatefulWidget {
  final String inventoryNumber;
  final String equipment;
  final String getDate;
  final String number;
  final bool last;
  final int firstFlexRow;
  final int secondFlexRow;
  final Function() onTap;
  final Widget? widget;
  const InventoryRow({
    Key? key,
    required this.equipment,
    required this.getDate,
    required this.inventoryNumber,
    required this.number,
    required this.last,
    required this.firstFlexRow,
    required this.secondFlexRow,
    required this.onTap,
    this.widget,
  }) : super(key: key);

  @override
  State<InventoryRow> createState() => _ClassroomEquipmentRowState();
}

class _ClassroomEquipmentRowState extends State<InventoryRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.widget == null)
              const SizedBox(
                height: 0,
              )
            else
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 12,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Transform.scale(
                      scale: 1.2,
                      child: widget.widget,
                    ),
                  ),
                ),
              ),
            Flexible(
              flex: widget.firstFlexRow,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 16,
                  right: 8,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.number,
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
              flex: widget.secondFlexRow,
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
                          widget.equipment,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: blackLabels,
                          ),
                        ),
                        Text(
                          widget.getDate,
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
