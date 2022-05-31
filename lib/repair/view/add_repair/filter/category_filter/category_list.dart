import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category_filter/category_row.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category_filter/visible_category_list.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    final categories =
        BlocProvider.of<CategoryBloc>(context).state.globalCategories;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Наименование',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: blackLabels,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                ),
              ),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return const VisibleCategoryList();
                  }
                  if (state.searchText.isNotEmpty &&
                      state.visibleList.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "Категорий не найдено",
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }
                  int _currentValue = 0;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryRow(
                        currentValue: _currentValue,
                        onChange: (category) {
                          setState(() {
                            print("click $index");
                            _currentValue = index;
                          });
                        },
                        category: categories[index].name,
                        last: index == categories.length - 1,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
