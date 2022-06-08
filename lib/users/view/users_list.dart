import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/update_user_page.dart';
import 'package:ptk_inventory/users/view/users_row.dart';
import 'package:ptk_inventory/users/view/visible_users_list.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = BlocProvider.of<UsersBloc>(context).state.globalUsers;
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
                      'Фамилия И. О.',
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
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state.visibleList.isNotEmpty) {
                  return const VisibleUsersList();
                }
                if (state.searchText.isNotEmpty && state.visibleList.isEmpty) {
                  return Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                        "Пользователи не найдены",
                                        style: TextStyle(
                                          color: blackLabels,
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
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
                                            padding: const EdgeInsets.symmetric(
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
                                            "для добавления нового пользователя",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: blackLabels,
                                              fontFamily: 'Rubik',
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
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

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                        id: users[index].id.toString(),
                        fullName:
                            "${users[index].surname} ${users[index].name[0]}. $patronymic",
                        last: index == users.length - 1,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
