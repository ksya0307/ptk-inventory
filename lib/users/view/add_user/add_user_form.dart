import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/add_user/add_user_button.dart';
import 'package:ptk_inventory/users/view/add_user/name_input.dart';
import 'package:ptk_inventory/users/view/add_user/password_input.dart';
import 'package:ptk_inventory/users/view/add_user/patronymic_input.dart';
import 'package:ptk_inventory/users/view/add_user/role_dropmenu.dart';
import 'package:ptk_inventory/users/view/add_user/surname_input.dart';
import 'package:ptk_inventory/users/view/add_user/username_input.dart';

class AddUserForm extends StatelessWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state.userActionStatus == UserActionStatus.added) {
          snackbarMessage(context, "Новый пользователь добавлен");
          Navigator.of(context).pop();
          //context.read<CategoryBloc>().add(const CategoryLoadList());
        }
        print(state.userActionStatus);
        if (state.userActionStatus == UserActionStatus.addedToGlobal) {
          Navigator.of(context).pop();
        }

        if (state.userActionStatus == UserActionStatus.notAdded) {
          snackbarMessageCommonError(
            context,
            "Логин уже используется",
          );
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SurnameInput(),
            const NameInput(),
            const PatronymicInput(),
            const UsernameInput(),
            PasswordInput(),
            const RoleDropDown(),
            AddUserButton()
          ],
        ),
      ),
    );
  }
}
