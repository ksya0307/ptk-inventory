import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryRow extends StatefulWidget {
  final String category;
  final bool last;
  final int value;
  final int groupValue;
  final Function(int?) onChange;
  const CategoryRow({
    Key? key,
    required this.category,
    required this.last,
    required this.groupValue,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 12,
                  right: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Radio(
                    groupValue: widget.groupValue,
                    onChanged: widget.onChange,
                    value: widget.value,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 12,
                  right: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: blackLabels,
                    ),
                  ),
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
