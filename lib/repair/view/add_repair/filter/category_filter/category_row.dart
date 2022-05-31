import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryRow extends StatelessWidget {
  final String category;
  final bool last;
  final int currentValue;
  final void Function(int) onChange;
  const CategoryRow({
    Key? key,
    required this.category,
    required this.last,
    required this.currentValue,
    required this.onChange,
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
                  top: 8,
                  bottom: 8,
                  left: 12,
                  right: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: RadioListTile(
                    value: currentValue,
                    onChanged: (category) => onChange,
                    groupValue: category,
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
                    category,
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
