import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/admin_user/view/profile/admin_profile_form.dart';

import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

class AdminProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AdminProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(userRepository: UserRepository()),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints view) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: view.maxHeight,
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                    child: const AdminProfileForm(),
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
