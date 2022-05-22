import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/common_user/view.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/user/bloc/new_password_bloc.dart';

class UserProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UserProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPasswordBloc(userRepository: UserRepository()),
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
                  child: BlocListener<NewPasswordBloc, NewPasswordState>(
                    listener: (context, state) {
                      if (state.formStatus == FormzStatus.submissionSuccess) {
                        snackbarMessage(
                          context,
                          "Пароль успешно изменён",
                        );
                        Navigator.of(context).pop();
                      } else if (state.formStatus ==
                          FormzStatus.submissionFailure) {
                        snackbarMessageCommonError(
                            context, "Пароль не удалось сохранить");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: const UserProfileView(),
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

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

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
                  Navigator.of(context).pop(CommonPage.route());
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 40,
                  color: blackLabels,
                ),
              ),
            ),
            const UserFullName(),
            propertyLabel('Логин', 24, 16),
            const UsernameField(),
            propertyLabel('Изменить пароль', 16, 16),
            const ChangePasswordField(),
            const _SavePasswordButton()
          ],
        ),
        Column(
          children: const [LogOutButton()],
        )
      ],
    );
  }
}

class _SavePasswordButton extends StatelessWidget {
  const _SavePasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const CircularProgressIndicator(color: primaryBlue),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(0, 47, 167, 0.65);
                        }
                        return const Color.fromRGBO(0, 47, 167, 1.0);
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    label: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
                      child: Text(
                        "Сохранение...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 0.65),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: ElevatedButton(
                    key: const Key('signUpForm_signUp_raisedButton'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      foregroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(255, 255, 255, 0.65);
                        }
                        return Colors.white;
                      }),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(0, 47, 167, 0.65);
                        }
                        return const Color.fromRGBO(0, 47, 167, 1.0);
                      }),
                    ),
                    onPressed: state.formStatus.isValidated
                        ? () {
                            context
                                .read<NewPasswordBloc>()
                                .add(const NewPasswordSaved());
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
                      child: Text(
                        "Сохранить",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class ChangePasswordField extends StatefulWidget {
  const ChangePasswordField({Key? key}) : super(key: key);

  @override
  State<ChangePasswordField> createState() => _ChangePasswordFieldState();
}

class _ChangePasswordFieldState extends State<ChangePasswordField> {
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: TextFormField(
            controller: passwordController,
            key: const Key('profile_passwordInput_textField'),
            onChanged: (password) => context
                .read<NewPasswordBloc>()
                .add(NewPasswordChanged(password)),
            cursorColor: Theme.of(context).primaryColor,
            minLines: 1,
            obscureText: _obscureText,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: Color.fromRGBO(68, 68, 68, 1.0),
            ),
            decoration: InputDecoration(
              hintText: "Новый пароль",
              errorText: state.newPassword.invalid
                  ? 'Длина должна быть не менее 8 символов'
                  : null,
              suffixIcon: IconButton(
                color: const Color.fromRGBO(156, 156, 156, 1.0),
                onPressed: _passwordVisibility,
                icon: Icon(
                  !_obscureText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(12, 12 + 3, 12, 12 + 3),
              hintStyle: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: Color.fromRGBO(150, 150, 150, 1.0),
              ),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(7.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(7.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(24, 81, 227, 0.75),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(150, 150, 150, 1.0),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 24, top: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: ElevatedButton(
          key: const Key('signUpForm_signUp_raisedButton'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryBlue),
          ),
          onPressed: () {
            context.read<AuthenticationBloc>().add(
                  AuthenticationLogoutRequested(),
                );
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
            child: Text(
              "Выйти из учетной записи",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserFullName extends StatefulWidget {
  const UserFullName({Key? key}) : super(key: key);

  @override
  State<UserFullName> createState() => _UserFullNameState();
}

class _UserFullNameState extends State<UserFullName> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final String patronymic = state.user.patronymic ?? '';
        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Text(
            "${state.user.surname} ${state.user.name} $patronymic",
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: blackLabels,
            ),
          ),
        );
      },
    );
  }
}

Widget propertyLabel(String property, double paddingTop, double paddingLeft) {
  return Padding(
    padding: EdgeInsets.only(top: paddingTop, left: paddingLeft),
    child: Text(
      property,
      style: const TextStyle(
        fontFamily: 'Rubik',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: blackLabels,
      ),
    ),
  );
}

class UsernameField extends StatefulWidget {
  const UsernameField({Key? key}) : super(key: key);

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, left: 16),
          child: Container(
            color: const Color.fromRGBO(239, 242, 249, 1.0),
            child: TextFormField(
              readOnly: true,
              minLines: 1,
              enabled: false,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: Color.fromRGBO(68, 68, 68, 1.0),
              ),
              decoration: InputDecoration(
                hintText: state.user.username,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                hintStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  color: Color.fromRGBO(150, 150, 150, 1.0),
                ),
                border: const OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: blueDisabled,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
              ),
            ),
          ),
        );
      },
    );
  }
}
