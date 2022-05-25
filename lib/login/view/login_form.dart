import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/login/login.dart';
import 'package:ptk_inventory/sign_up/view/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _loginForm();
  }

  Widget _loginForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const UsernameInput(),
          const SizedBox(height: 12),
          const PasswordInput(),
          const SizedBox(height: 12),
          LoginButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class SignUpLabel extends StatelessWidget {
  const SignUpLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return SignUpPage();
            },
          ),
        );
      },
      child: const SizedBox(
        height: 48,
        width: 160,
        child: Text(
          "Создать профиль",
          style: TextStyle(
            color: blueCustom,
            fontFamily: 'Rubik',
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
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
            labelText: 'Логин',
            errorText:
                state.username.invalid ? 'Логин не может быть пустым' : null,
            suffixIcon: const Icon(
              Icons.login_rounded,
              color: greyDark,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
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
            // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      //если пароли не равны друг другу то будет rebuild виджета, если равны то его не будет
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
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
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            labelText: 'Пароль',
            errorText:
                state.password.invalid ? 'Пароль не может быть пустым' : null,
            suffixIcon: IconButton(
              color: greyDark,
              onPressed: _passwordVisibility,
              icon: Icon(
                !_obscureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: Color.fromRGBO(150, 150, 150, 1.0),
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
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
                      "Вход...",
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
            : Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: ElevatedButton(
                      key: const Key('loginForm_logIn_elevatedButton'),
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
                                  .read<LoginBloc>()
                                  .add(const LoginSubmitted());
                            }
                          : null,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
                        child: Text(
                          "Войти",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SignUpLabel(),
                ],
              );
      },
    );
  }
}
