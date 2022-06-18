import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_form.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/component/show_all_label.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';

class ShowAllFilter extends StatelessWidget {
  const ShowAllFilter({
    Key? key,
    this.widget,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
    required this.property,
    required this.action,
    required this.containerColor,
  }) : super(key: key);
  final Widget? widget;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
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
              return InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) {
                      //исправить
                      return state.user.role == UserRole.moderator ||
                              state.user.role == UserRole.admin
                          ? BlocProvider<CategoryBloc>.value(
                              value: context.read<CategoryBloc>()
                                ..add(const CategoryLoadList()),
                              child: EquipmentFilterSheet(
                                initialChildSize: 0.7,
                                minChildSize: 0.5,
                                maxChildSize: 0.95,
                                title: 'Все категории',
                                widget: Column(
                                  children: [
                                    BlocBuilder<CategoryBloc, CategoryState>(
                                      buildWhen: (previous, current) =>
                                          previous.visibleList !=
                                          current.visibleList,
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
                                      height: 8,
                                    ),
                                    CategoryForm(
                                      firstFlexRow: firstFlexRow,
                                      secondFlexRow: secondFlexRow,
                                      firstFlex: firstFlex,
                                      secondFlex: secondFlex,
                                      topPaddingCategoryList: 0,
                                      topPaddingSearchCategory: 0,
                                      categoryNotFoundWidget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          // direction: Axis.vertical,
                                          children: [
                                            const Text(
                                              "Используйте",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryBlue,
                                                ),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "для добавления новой категории",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : BlocProvider<CategoryBloc>.value(
                              value: context.read<CategoryBloc>()
                                ..add(const CategoryInUserClassrooms()),
                              child: EquipmentFilterSheet(
                                initialChildSize: 0.7,
                                minChildSize: 0.5,
                                maxChildSize: 0.95,
                                title: 'Все категории',
                                widget: Column(
                                  children: [
                                    BlocBuilder<CategoryBloc, CategoryState>(
                                      buildWhen: (previous, current) =>
                                          previous.visibleList !=
                                          current.visibleList,
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
                                      height: 8,
                                    ),
                                    CategoryForm(
                                      firstFlexRow: firstFlexRow,
                                      secondFlexRow: secondFlexRow,
                                      firstFlex: firstFlex,
                                      secondFlex: secondFlex,
                                      topPaddingCategoryList: 0,
                                      topPaddingSearchCategory: 0,
                                      categoryNotFoundWidget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          // direction: Axis.vertical,
                                          children: [
                                            const Text(
                                              "Используйте",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryBlue,
                                                ),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "для добавления новой категории",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
