import 'package:flutter/material.dart';
import 'package:ptk_inventory/repair/common/property_label.dart';
import 'package:ptk_inventory/repair/common/show_all_label.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PropertyLabel(
                property: 'Категория',
                bottomPadding: 0,
              ),
              ShowAllLabel(property: 'Показать все', bottomPadding: 0)
            ],
          ),
        ),
      ),
    );
  }
}
