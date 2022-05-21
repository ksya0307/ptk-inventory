import 'package:flutter/material.dart';
import 'package:ptk_inventory/category/view/add_category_page.dart';
import 'package:ptk_inventory/config/colors.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(AddCategoryPage.route()),
      child: const SizedBox(
        height: 48,
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "Добавить",
            style: TextStyle(
              color: primaryBlue,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
