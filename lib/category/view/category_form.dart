import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_list.dart';
import 'package:ptk_inventory/category/view/search_category.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchCategory(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: BlocBuilder<CategoryBloc, CategoryState>(
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
                  return const CategoriesList();
                }
                if (state.categoryLoadingStatus ==
                        CategoryLoadingStatus.loadingSuccess &&
                    state.globalCategories.isEmpty) {
                  return const Text("Список категорий пуст");
                }

                return const Text("Что-то пошло не так");
              },
            ),
          ),
        ],
      ),
    );
  }
}
