import 'package:flutter/material.dart';

import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/common/component/custom_dropdown.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryDropDown extends StatefulWidget {
  final List<Category> globalCategories;
  final String? category;
  final void Function(String?) onChanged;
  final String? value;
  const CategoryDropDown({
    Key? key,
    required this.globalCategories,
    this.category,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  String? category;
  List<String> categories = [];
  @override
  void initState() {
    for (final category in widget.globalCategories) {
      categories.add(category.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CustomDropdown(
        dropDownWidget: Theme(
          data: Theme.of(context).copyWith(canvasColor: greyCard),
          child: DropdownButton<String>(
            hint: const Text("Выберите категорию"),
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: primaryBlue,
            ),
            value: widget.value,
            // value: widget.category == "" ? "" : widget.category,
            onChanged: widget.onChanged,
            // (String? value) {
            //   setState(() {
            //     category = value ?? "";
            //   });
            // },
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: const TextStyle(
                    color: blackInput,
                    fontFamily: 'Rubik',
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
