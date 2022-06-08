import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/search_user_input.dart';
import 'package:ptk_inventory/users/view/users_list.dart';

class UsersForm extends StatelessWidget {
  const UsersForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async =>
          BlocProvider.of<UsersBloc>(context)..add(const UsersLoadList()),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchUser(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.userLoadingStatus ==
                        UserLoadingStatus.loadingInProgress) {
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
                                      "Загрузка пользователей...",
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
                    if (state.userLoadingStatus ==
                            UserLoadingStatus.loadingSuccess &&
                        state.globalUsers.isNotEmpty) {
                      return const UsersList();
                    }
                    if (state.userLoadingStatus ==
                            UserLoadingStatus.loadingSuccess &&
                        state.globalUsers.isEmpty) {
                      return const Text("Список пользователей пуст");
                    }

                    return const Text("Что-то пошло не так");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
