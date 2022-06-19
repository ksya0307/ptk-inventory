import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_list.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({
    Key? key,
    required this.topPaddingSearchCategory,
    this.search,
    this.categoryNotFoundWidget,
    this.widget,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);
  final double topPaddingSearchCategory;
  final Widget? search;
  final Widget? categoryNotFoundWidget;
  final Widget? widget;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (search != null)
          Column(
            children: [
              search!,
              const SizedBox(
                height: 8,
              )
            ],
          )
        else
          const SizedBox(
            height: 0,
          ),
        BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (previous, current) =>
              previous.globalCategories != current.globalCategories,
          builder: (context, state) {
            if (state.categoryLoadingStatus ==
                CategoryLoadingStatus.loadingInProgress) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              "Загрузка категорий...",
                              style: TextStyle(
                                color: greyDark,
                                fontFamily: 'Rubik',
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state.categoryLoadingStatus ==
                    CategoryLoadingStatus.loadingSuccess &&
                state.globalCategories.isNotEmpty) {
              // print("${state.visibleList}");
              return CategoriesList(
                firstFlexRow: firstFlexRow,
                secondFlexRow: secondFlexRow,
                firstFlex: firstFlex,
                secondFlex: secondFlex,
                radioButton: widget,
                categoryNotFoundWidget: categoryNotFoundWidget,
              );
            }
            if (state.categoryLoadingStatus ==
                    CategoryLoadingStatus.loadingSuccess &&
                state.globalCategories.isEmpty) {
              return const Text("Список категорий оборудования пуст");
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "Загрузка категорий...",
                            style: TextStyle(
                              color: greyDark,
                              fontFamily: 'Rubik',
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
