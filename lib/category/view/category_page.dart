import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/category/view/add_category/add_category_page.dart';
import 'package:ptk_inventory/category/view/category_form.dart';
import 'package:ptk_inventory/category/view/search_category.dart';

class CategoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryBloc(categoryRepository: CategoryRepository())
            ..add(const CategoryLoadList()),
      child: Scaffold(
        floatingActionButton: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return FloatingActionButton(
              tooltip: "Добавить категорию",
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<CategoryBloc>.value(
                    value: context.read<CategoryBloc>(),
                    child: AddCategoryPage(),
                  ),
                ),
              ),
            );
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            tooltip: "Назад",
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Категории",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints view) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: view.maxHeight,
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      children: const [
                        CategoryForm(
                          search: SearchCategory(),
                          topPaddingCategoryList: 8,
                          topPaddingSearchCategory: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
