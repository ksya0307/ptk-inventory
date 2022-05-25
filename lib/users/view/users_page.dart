import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/sign_up/view/sign_up_page.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/add_user/add_user_page.dart';
import 'package:ptk_inventory/users/view/users_form.dart';

class UsersPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UsersPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(userRepository: UserRepository())
        ..add(const UsersLoadList()),
      child: Scaffold(
        floatingActionButton: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            return FloatingActionButton(
              tooltip: "Добавить пользователя",
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<UsersBloc>.value(
                    value: context.read<UsersBloc>(),
                    child: AddUserPage(),
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
            "Пользователи",
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
                        UsersForm(),
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
