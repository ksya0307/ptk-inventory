import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category_filter/apply_filter_button.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category_filter/search_category.dart';
import 'package:ptk_inventory/repair/view/common/property_label.dart';
import 'package:ptk_inventory/repair/view/common/show_all_label.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: const [
              PropertyLabel(
                property: 'Категория',
                bottomPadding: 0,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => showModalBottomSheet<void>(
            builder: (_) {
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24, top: 24),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: primaryBlue,
                                  ),
                                ),
                                Expanded(
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: const [
                                      Spacer(),
                                      Text(
                                        "Все категории",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: primaryBlue,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SearchCategory(),
                      const ApplyFilter()
                    ],
                  ),
                ),
              );
            },
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: const [
                ShowAllLabel(
                  property: 'Показать все',
                  bottomPadding: 0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
