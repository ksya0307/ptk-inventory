import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/category_row.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';

class VisibleCategoryList extends StatelessWidget {
  const VisibleCategoryList({Key? key}) : super(key: key);

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
                      print(state);
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (state.user.role == UserRole.admin ||
                                  state.user.role == UserRole.moderator) {
                                print("moderator or admin");
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
                              id: categories[index].id.toString(),
                              category: categories[index].name,
                              last: index == categories.length - 1,
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
