import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/category_row.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';

class VisibleCategoryList extends StatefulWidget {
    final Widget? categoryNotFoundWidget;
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  const VisibleCategoryList({
    Key? key,
    this.categoryNotFoundWidget,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<VisibleCategoryList> createState() => _VisibleCategoryListState();
}

class _VisibleCategoryListState extends State<VisibleCategoryList> {
    int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final categories = state.visibleList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: greyCard,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    buildWhen: (previous, current) =>
                        previous.user.role != current.user.role,
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
                                                      categories[index],),);
                                        });
                                      },
                                    ),
                                  ),
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
