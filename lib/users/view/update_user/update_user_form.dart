import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/delete_button.dart';
import 'package:ptk_inventory/common/component/modal_bottom_sheet_delete.dart';
import 'package:ptk_inventory/common/component/property_input.dart';

import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/input/password_input.dart';
import 'package:ptk_inventory/users/view/update_user/role_dropmenu.dart';

class UpdateUserForm extends StatelessWidget {
  const UpdateUserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
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
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PropertyInput(
                      initialValue: state.selectedUser!.name,
                      errorText: 'Имя не может быть пустым',
                      propertyInvalid: state.name.invalid,
                      hintText: 'Иван',
                      onChange: (name) =>
                          context.read<UsersBloc>().add(UsersNameChanged(name)),
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
                      errorText: 'Длина пароля должна быть не менее 8 символов',
                      propertyInvalid: false,
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
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: BlocListener<UsersBloc, UsersState>(
                  listener: (context, state) {
                    if (state.userActionStatus == UserActionStatus.saved) {
                      snackbarMessage(context, "Данные пользователя сохранены");
                      context.read<UsersBloc>().add(
                            UsersSaveToList(
                              user: state.selectedUser!,
                            ),
                          );
                      context.read<UsersBloc>().add(const UsersSelected(null));
                    }
                    if (state.userActionStatus ==
                        UserActionStatus.savedOnGlobal) {
                      context.read<UsersBloc>().add(const UsersSelected(null));
                      Navigator.of(context).pop();
                    }

                    if (state.userActionStatus == UserActionStatus.notSaved) {
                      snackbarMessageCommonError(
                        context,
                        "Логин уже используется",
                      );
                    }
                  },
                  child: BlocBuilder<UsersBloc, UsersState>(
                    buildWhen: (previous, current) =>
                        previous.formStatus != current.formStatus,
                    builder: (context, state) {
                      return state.formStatus.isSubmissionInProgress
                          ? const InProgress(
                              inProgressText: 'Сохранение...',
                            )
                          : CommonButton(
                              fontSize: 18,
                              formValidated: state.formStatus.isValidated,
                              buttonText: 'Сохранить',
                              onPress: () {
                                context
                                    .read<UsersBloc>()
                                    .add(const UsersSaved());
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              BlocListener<UsersBloc, UsersState>(
                listener: (context, state) {
                  if (state.userActionStatus == UserActionStatus.deleted) {
                    snackbarMessage(context, "Пользователь удален");
                  }

                  if (state.userActionStatus ==
                      UserActionStatus.deletedFromGlobal) {
                    Navigator.of(context).pop();
                  }
                  if (state.userActionStatus == UserActionStatus.notDeleted) {
                    snackbarMessageError(
                      context,
                      "Пользователь не может быть удален",
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: BlocBuilder<UsersBloc, UsersState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: DeleteButton(
                          bottomSheet: BlocProvider.value(
                            value: context.read<UsersBloc>(),
                            child: ConfirmDeletingBottomSheet(
                              deleteProperty: 'пользователя',
                              onPress: () {
                                context
                                    .read<UsersBloc>()
                                    .add(UsersDeleted(state.selectedUser!.id));
                                Navigator.of(context).pop();
                                context.read<UsersBloc>().add(
                                      UsersDeleteFromList(
                                        user: state.selectedUser!,
                                      ),
                                    );
                                context
                                    .read<UsersBloc>()
                                    .add(const UsersSelected(null));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
