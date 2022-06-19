import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/category_row.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/category/view/visible_category_list.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';

class CategoriesList extends StatefulWidget {
  final Widget? categoryNotFoundWidget;
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  const CategoriesList({
    Key? key,
    this.categoryNotFoundWidget,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int groupValue = -1;
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
                  if (widget.radioButton != null)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, top: 16, bottom: 16,),
                        child: Container(
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 0,
                    ),
                  Flexible(
                    flex: widget.firstFlex,
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
                    flex: widget.secondFlex,
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
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return VisibleCategoryList(
                      radioButton: widget.radioButton,
                      firstFlex: widget.firstFlex,
                      firstFlexRow: widget.firstFlexRow,
                      secondFlex: widget.secondFlex,
                      secondFlexRow: widget.secondFlexRow,
                    );
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
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "Категория не найдена",
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      BlocBuilder<AuthenticationBloc,
                                          AuthenticationState>(
                                        builder: (context, state) {
                                          return state.user.role ==
                                                      UserRole.admin ||
                                                  state.user.role ==
                                                      UserRole.moderator
                                              ? widget.categoryNotFoundWidget!
                                              : const SizedBox(height: 0);
                                        },
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

                  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return widget.radioButton == null
                              ? InkWell(
                                  onTap: () {
                                    if (state.user.role == UserRole.admin ||
                                        state.user.role == UserRole.moderator) {
                                      context.read<CategoryBloc>().add(
                                            CategorySelected(
                                              Category(
                                                id: categories[index].id,
                                                name: categories[index].name,
                                              ),
                                            ),
                                          );
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<CategoryBloc>(),
                                            child: UpdateCategoryPage(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: CategoryRow(
                                
                                    firstFlexRow: widget.firstFlexRow,
                                    secondFlexRow: widget.secondFlexRow,
                                    id: (index + 1).toString(),
                                    category: categories[index].name,
                                    last: index == categories.length - 1,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    if (state.user.role == UserRole.admin ||
                                        state.user.role == UserRole.moderator) {
                                      context.read<CategoryBloc>().add(
                                            CategorySelected(
                                              Category(
                                                id: categories[index].id,
                                                name: categories[index].name,
                                              ),
                                            ),
                                          );
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<CategoryBloc>(),
                                            child: UpdateCategoryPage(),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: CategoryRow(
                                    firstFlexRow: widget.firstFlexRow,
                                    secondFlexRow: widget.secondFlexRow,
                                    id: (index + 1).toString(),
                                    category: categories[index].name,
                                    last: index == categories.length - 1,
                                    radio: Radio<int>(
                                      groupValue: groupValue,
                                      value: index,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value!;
                                          context
                                              .read<ClassroomEquipmentBloc>()
                                              .add(
                                                ClassroomEquipmentSpecsCategorySelected(
                                                  categories[index],
                                                ),
                                              );
                                          context.read<CategoryBloc>().add(
                                                CategorySelected(
                                                  categories[index],
                                                ),
                                              );
                                        });
                                      },
                                    ),
                                  ),
                                );
                        },
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
