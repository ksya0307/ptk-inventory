import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/common/component/apply_filter_label.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/component/show_all_label.dart';

import 'package:ptk_inventory/repair/view/add_repair/filter/category_filter/category_form.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<CategoryBloc>(context)
                  ..add(const CategoryUserClassrooms()),
                child: EquipmentFilterSheet(
                  title: 'Все категории',
                  widget: Column(
                    children: [
                      BlocBuilder<CategoryBloc, CategoryState>(
                        buildWhen: (previous, current) =>
                            previous.visibleList != current.visibleList,
                        builder: (context, state) {
                          return SearchField(
                            hintText: 'Смартфон',
                            keyboardType: TextInputType.text,
                            inputFormatters: const [],
                            onChange: (category) => {
                              context.read<CategoryBloc>().add(
                                    CategorySearch(
                                      matchingWord: category,
                                    ),
                                  ),
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            ApplyFilterLabel(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const CategoryForm(),
                    ],
                  ),
                ),
              );
            },
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
