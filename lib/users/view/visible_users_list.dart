import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/update_user_page.dart';
import 'package:ptk_inventory/users/view/users_row.dart';

class VisibleUsersList extends StatelessWidget {
  const VisibleUsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        final users = state.visibleList;
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final String patronymic = users[index].patronymic != null
                          ? "${users[index].patronymic![0]}."
                          : "";
                      return InkWell(
                        onTap: () {
                          context.read<UsersBloc>().add(
                                UsersSelected(
                                  User(
                                    id: users[index].id,
                                    name: users[index].name,
                                    role: users[index].role,
                                    surname: users[index].surname,
                                    username: users[index].username,
                                    patronymic: users[index].patronymic ?? '',
                                  ),
                                ),
                              );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: context.read<UsersBloc>(),
                                child: UpdateUserPage(),
                              ),
                            ),
                          );
                        },
                        child: UsersRow(
                          id: (index + 1).toString(),
                          fullName:
                              "${users[index].surname} ${users[index].name[0]}. $patronymic",
                          last: index == users.length - 1,
                        ),
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
