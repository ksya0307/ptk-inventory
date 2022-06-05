import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_form.dart';
import 'package:ptk_inventory/common/component/apply_filter_label.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';

import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/component/show_all_label.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';

class ShowAllFilter extends StatelessWidget {
  const ShowAllFilter({
    Key? key,
    required this.property,
    required this.action,
    required this.containerColor,
  }) : super(key: key);
  final String property;
  final String action;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                PropertyLabel(
                  property: property,
                  bottomPadding: 0,
                  leftPadding: 12,
                ),
              ],
            ),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              final allCategories = context.read<CategoryBloc>()
                ..add(
                  const CategoryLoadList(),
                );
              final teacherCategories = context.read<CategoryBloc>()
                ..add(const CategoryInUserClassrooms());
              return InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      return BlocProvider<CategoryBloc>.value(
                        value: state.user.role == UserRole.admin ||
                                state.user.role == UserRole.moderator
                            ? allCategories
                            : teacherCategories,
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
                              const CategoryForm(
                                topPaddingCategoryList: 0,
                                topPaddingSearchCategory: 0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      ShowAllLabel(
                        property: action,
                        bottomPadding: 0,
                        rightPadding: 4,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
