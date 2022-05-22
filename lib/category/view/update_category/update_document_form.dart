import 'package:flutter/material.dart';
import 'package:ptk_inventory/category/view/common/category_name_label.dart';
import 'package:ptk_inventory/category/view/update_category/category_name_input.dart';
import 'package:ptk_inventory/category/view/update_category/delete_category_button.dart';
import 'package:ptk_inventory/category/view/update_category/save_category_button.dart';

class UpdateCategoryForm extends StatelessWidget {
  const UpdateCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CategoryNameLabel(),
            CategoryNameInput(),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: SaveCategoryButton(),
            ),
          ],
        ),
        Column(
          children: const [DeleteCategoryButton()],
        )
      ],
    );
  }
}
