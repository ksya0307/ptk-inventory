import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';
import 'package:ptk_inventory/users/view/update_user/input/password_input.dart';

class AdminProfileForm extends StatelessWidget {
  const AdminProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 40,
                  color: blackLabels,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PropertyLabel(property: 'Фамилия', bottomPadding: 8),
                  BlocBuilder<UsersBloc, UsersState>(
                    buildWhen: (previous, current) =>
                        previous.surname != current.surname,
                    builder: (context, state) {
                      return PropertyInput(
                        errorText: "Фамилия не может быть пустой",
                        propertyInvalid:
                            context.read<UsersBloc>().state.surname.invalid,
                        onChange: (surname) => context
                            .read<UsersBloc>()
                            .add(UsersSurnameChanged(surname)),
                        suffixIcon: const Icon(Icons.edit_rounded),
                        initialValue: context
                            .read<AuthenticationBloc>()
                            .state
                            .user
                            .surname,
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: PropertyLabel(property: 'Имя', bottomPadding: 8),
                  ),
                  BlocBuilder<UsersBloc, UsersState>(
                    buildWhen: (previous, current) =>
                        previous.name != current.name,
                    builder: (context, state) {
                      return PropertyInput(
                        propertyInvalid:
                            context.read<UsersBloc>().state.name.invalid,
                        errorText: "Имя не может быть пустым",
                        onChange: (name) => context
                            .read<UsersBloc>()
                            .add(UsersNameChanged(name)),
                        suffixIcon: const Icon(Icons.edit_rounded),
                        initialValue:
                            context.read<AuthenticationBloc>().state.user.name,
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child:
                        PropertyLabel(property: 'Отчество', bottomPadding: 8),
                  ),
                  PropertyInput(
                    suffixIcon: const Icon(Icons.edit_rounded),
                    onChange: (patronymic) => context
                        .read<UsersBloc>()
                        .add(UsersPatronymicChanged(patronymic)),
                    initialValue: context
                            .read<AuthenticationBloc>()
                            .state
                            .user
                            .patronymic ??
                        '',
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: PropertyLabel(property: 'Логин', bottomPadding: 8),
                  ),
                  PropertyInput(
                    propertyInvalid:
                        context.read<UsersBloc>().state.username.invalid,
                    errorText: 'Логин не может быть пустым',
                    suffixIcon: const Icon(Icons.edit_rounded),
                    onChange: (username) => context
                        .read<UsersBloc>()
                        .add(UsersUsernameChanged(username)),
                    initialValue:
                        context.read<AuthenticationBloc>().state.user.username,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: PropertyLabel(property: 'Пароль', bottomPadding: 8),
                  ),
                  BlocBuilder<UsersBloc, UsersState>(
                    builder: (context, state) {
                      return PasswordInput(
                        errorText:
                            'Длина пароля должна быть не менее 8 символов',
                        hintText: 'Новый пароль',
                        propertyInvalid: state.password.invalid,
                        onChange: (password) => context
                            .read<UsersBloc>()
                            .add(UsersPasswordChanged(password)),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            BlocBuilder<UsersBloc, UsersState>(
              buildWhen: (previous, current) =>
                  previous.formStatus != current.formStatus,
              builder: (context, state) {
                return state.formStatus.isSubmissionInProgress
                    ? const Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 24, top: 24),
                        child: InProgress(
                          inProgressText: 'Сохранение...',
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 24,
                          top: 24,
                        ),
                        child: CommonButton(
                          fontSize: 18,
                          formValidated: state.formStatus.isValidated,
                          buttonText: 'Сохранить',
                          onPress: () {
                            context.read<UsersBloc>().add(const UsersSaved());
                          },
                        ),
                      );
              },
            ),
          ],
        )
      ],
    );
  }
}
