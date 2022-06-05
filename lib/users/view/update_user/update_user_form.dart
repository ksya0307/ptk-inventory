import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/common/component/property_input.dart';

import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/delete_user_button.dart';
import 'package:ptk_inventory/users/view/update_user/input/password_input.dart';
import 'package:ptk_inventory/users/view/update_user/role_dropmenu.dart';
import 'package:ptk_inventory/users/view/update_user/save_user_button.dart';

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
                const PropertyLabel(property: 'Фамилия', bottomPadding: 8),
                BlocBuilder<UsersBloc, UsersState>(
                  buildWhen: (previous, current) =>
                      previous.surname != current.surname,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PropertyInput(
                        initialValue: state.selectedUser!.surname,
                        errorText: 'Фамилия не может быть пустой',
                        propertyInvalid: state.surname.invalid,
                        hintText: 'Иванов',
                        onChange: (surname) => context
                            .read<UsersBloc>()
                            .add(UsersSurnameChanged(surname)),
                      ),
                    );
                  },
                ),
                const PropertyLabel(property: 'Имя', bottomPadding: 8),
                BlocBuilder<UsersBloc, UsersState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PropertyInput(
                        initialValue: state.selectedUser!.name,
                        errorText: 'Имя не может быть пустым',
                        propertyInvalid: state.name.invalid,
                        hintText: 'Иван',
                        onChange: (name) => context
                            .read<UsersBloc>()
                            .add(UsersNameChanged(name)),
                      ),
                    );
                  },
                ),
                const PropertyLabel(property: 'Отчество', bottomPadding: 8),
                BlocBuilder<UsersBloc, UsersState>(
                  buildWhen: (previous, current) =>
                      previous.patronymic != current.patronymic,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PropertyInput(
                        initialValue: state.selectedUser!.patronymic,
                        hintText: 'Иванович',
                        onChange: (patronymic) => context
                            .read<UsersBloc>()
                            .add(UsersPatronymicChanged(patronymic)),
                      ),
                    );
                  },
                ),
                const PropertyLabel(property: 'Логин', bottomPadding: 8),
                BlocBuilder<UsersBloc, UsersState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PropertyInput(
                        initialValue: state.selectedUser!.username,
                        errorText: 'Логин не может быть пустым',
                        propertyInvalid: state.username.invalid,
                        hintText: 'ivan.ivanov',
                        onChange: (username) => context
                            .read<UsersBloc>()
                            .add(UsersUsernameChanged(username)),
                      ),
                    );
                  },
                ),
                const PropertyLabel(property: 'Пароль', bottomPadding: 8),
                BlocBuilder<UsersBloc, UsersState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PasswordInput(
                        errorText: 'Длина должна быть не менее 8 символов',
                        propertyInvalid: state.password.invalid,
                        hintText: 'Новый пароль',
                        onChange: (password) => context
                            .read<UsersBloc>()
                            .add(UsersPasswordChanged(password)),
                      ),
                    );
                  },
                ),
                const PropertyLabel(property: 'Роль', bottomPadding: 8),
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
