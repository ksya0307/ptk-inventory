import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/role_dropmenu.dart';
import 'package:ptk_inventory/users/view/common/property_label.dart';
import 'package:ptk_inventory/users/view/update_user/delete_user_button.dart';
import 'package:ptk_inventory/users/view/update_user/name_input.dart';
import 'package:ptk_inventory/users/view/update_user/password_input.dart';
import 'package:ptk_inventory/users/view/update_user/patronymic_input.dart';
import 'package:ptk_inventory/users/view/update_user/save_user_button.dart';
import 'package:ptk_inventory/users/view/update_user/surname_input.dart';
import 'package:ptk_inventory/users/view/update_user/username_input.dart';

class UpdateUserForm extends StatelessWidget {
  const UpdateUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state.userActionStatus == UserActionStatus.saved) {
          snackbarMessage(context, "Данные пользователя сохранены");
          Navigator.of(context).pop();
          //context.read<CategoryBloc>().add(const CategoryLoadList());
        }

        if (state.userActionStatus == UserActionStatus.notSaved) {
          snackbarMessageCommonError(
            context,
            "Пользователь уже существует",
          );
        }
      },
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PropertyLabel(property: 'Фамилия'),
                const SurnameInput(),
                const PropertyLabel(property: 'Имя'),
                const NameInput(),
                const PropertyLabel(property: 'Отчество'),
                const PatronymicInput(),
                const PropertyLabel(property: 'Логин'),
                const UsernameInput(),
                const PropertyLabel(property: 'Пароль'),
                PasswordInput(),
                const PropertyLabel(property: 'Роль'),
                const RoleDropDown(),
                const SaveUserButton(),
              ],
            ),
            Column(
              children: const [DeleteUserButton()],
            )
          ],
        ),
      ),
    );
  }
}
