import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/login/login.dart';
import 'package:ptk_inventory/sign_up/bloc/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(LoginPage.route());
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 40,
                  color: blackLabels,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 24),
              child: Text(
                "Создание профиля",
                style: TextStyle(
                  color: blackLabels,
                  fontSize: 22,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: SurnameInput(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: NameInput(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: PatronymicInput(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: UsernameInput(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: PasswordInput(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: SignUpButton(),
            )
          ],
        ),
      ),
    );
  }
}

class SurnameInput extends StatelessWidget {
  const SurnameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.surname != current.surname,
      builder: (context, state) {
        return TextFormField(
          onChanged: (surname) =>
              context.read<SignUpBloc>().add(SignUpSurnameChanged(surname)),
          key: const Key('signUpForm_surnameInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            errorText:
                state.surname.invalid ? 'Фамилия не может быть пустой' : null,
            labelText: 'Фамилия',
            contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: redCustom,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueInputFocuced,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyDark,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          onChanged: (name) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(name)),
          key: const Key('signUpForm_nameInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorText:
                state.surname.invalid ? 'Имя не может быть пустым' : null,
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            labelText: 'Имя',
            contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: blackInput,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: redCustom,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueInputFocuced,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyDark,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        );
      },
    );
  }
}

class PatronymicInput extends StatelessWidget {
  const PatronymicInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.patronymic != current.patronymic,
      builder: (context, state) {
        return TextFormField(
          onChanged: (patronymic) => context
              .read<SignUpBloc>()
              .add(SignUpPatronymicChanged(patronymic)),
          key: const Key('signUpForm_patronymicInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            labelText: 'Отчество',
            contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: redCustom,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueInputFocuced,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyDark,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        );
      },
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          onChanged: (username) =>
              context.read<SignUpBloc>().add(SignUpUsernameChanged(username)),
          key: const Key('signUpForm_usernameInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorText:
                state.username.invalid ? 'Логин не может быть пустым' : null,
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            labelText: 'Логин',
            contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: redCustom,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueInputFocuced,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyDark,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  @override
  State<PasswordInput> createState() => _PasswordInput();
}

class _PasswordInput extends State<PasswordInput> {
  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) =>
              context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
          key: const Key('signUpForm_passwordInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          obscureText: _obscureText,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorText: state.password.invalid
                ? 'Длина пароля должна быть не менее 8 символов'
                : null,
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            labelText: 'Пароль',
            suffixIcon: IconButton(
              color: const Color.fromRGBO(156, 156, 156, 1.0),
              onPressed: _passwordVisibility,
              icon: Icon(
                !_obscureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redCustom, width: 1.5),
              borderRadius: BorderRadius.circular(7.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueInputFocuced,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: greyDark,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
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
                      "Регистрация...",
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
              )
            : ConstrainedBox(
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
                    backgroundColor: MaterialStateProperty.all(
                      primaryBlue,
                    ),
                  ),
                  onPressed: state.formStatus.isValidated
                      ? () {
                          context
                              .read<SignUpBloc>()
                              .add(const SignUpSubmitted());
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
                    child: Text(
                      "Создать",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
