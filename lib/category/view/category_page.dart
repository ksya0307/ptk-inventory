import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/category/view/add_category_page.dart';
import 'package:ptk_inventory/category/view/update_category_page.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

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
        floatingActionButton: FloatingActionButton(
          tooltip: "Добавить категорию",
          child: const Icon(Icons.add_rounded),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BlocProvider.value(
                value: context.read<CategoryBloc>(),
                child: AddCategoryPage(),
              ),
            ),
          ),
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
                        CategoryForm(),
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
                          )),
                    ],
                  );
                }
                if (state.categoryLoadingStatus ==
                        CategoryLoadingStatus.loadingSuccess &&
                    state.globalCategories.isNotEmpty) {
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

class PageNumber extends StatefulWidget {
  const PageNumber({Key? key}) : super(key: key);

  @override
  State<PageNumber> createState() => _PageNumberState();
}

class _PageNumberState extends State<PageNumber> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        "1",
        style: TextStyle(color: blackLabels, fontSize: 18),
      ),
    );
  }
}

class SearchCategory extends StatefulWidget {
  const SearchCategory({Key? key}) : super(key: key);

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
          child: Theme(
            data: ThemeData(
              textSelectionTheme:
                  const TextSelectionThemeData(selectionColor: blueCustom),
            ),
            child: TextField(
              controller: _textController,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                color: blackLabels,
              ),
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                hintText: 'Смартфон',
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: primaryBlue,
                ),
                suffixIcon: _textController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: primaryBlue,
                        ),
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories =
        BlocProvider.of<CategoryBloc>(context).state.globalCategories;
    return Padding(
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
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '№',
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
                Flexible(
                  flex: 5,
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CategoryBloc>(),
                        child: UpdateCategoryPage(),
                      ),
                    ),
                  ),
                  child: CategoryRow(
                    id: categories[index].id.toString(),
                    category: categories[index].name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {
  final String id;
  final String category;
  const CategoryRow({
    Key? key,
    required this.id,
    required this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  left: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    id,
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: blackLabels,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  category,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    color: blackLabels,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
      ],
    );
  }
}

class PreviousPageButton extends StatelessWidget {
  const PreviousPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: greyCard,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Icon(
          Icons.navigate_before_rounded,
          color: blueDisabled,
        ),
      ),
    );
  }
}

class NextPageButton extends StatelessWidget {
  const NextPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: greyCard,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Icon(
          Icons.navigate_next_rounded,
          color: primaryBlue,
        ),
      ),
    );
  }
}
