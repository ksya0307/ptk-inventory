import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryNameLabel extends StatelessWidget {
  const CategoryNameLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        'Название',
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
