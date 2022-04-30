import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/login/login.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: _loginForm(),
    );
  }

  Widget _loginForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _UsernameInput(),
          const SizedBox(height: 16),
          _PasswordInput(),
          const SizedBox(height: 16),
          _LoginButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatefulWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  State<_UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<_UsernameInput> {
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
            fontFamily: 'PT Sans Caption',
            fontSize: 18,
            color: Color.fromRGBO(68, 68, 68, 1.0),
          ),
          decoration: InputDecoration(
            labelText: 'Логин',
            errorText:
                state.username.invalid ? 'Логин не может быть пустым' : null,
            suffixIcon: const Icon(
              Icons.login_rounded,
              color: Color.fromRGBO(156, 156, 156, 1.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            hintStyle: const TextStyle(
              fontFamily: 'PT Sans Caption',
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
            // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => PasswordInput();
}

class PasswordInput extends State<_PasswordInput> {
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
            fontFamily: 'PT Sans Caption',
            fontSize: 18,
            color: Color.fromRGBO(68, 68, 68, 1.0),
          ),
          decoration: InputDecoration(
            labelText: 'Пароль',
            errorText:
                state.password.invalid ? 'Пароль не может быть пустым' : null,
            suffixIcon: IconButton(
              color: const Color.fromRGBO(156, 156, 156, 1.0),
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
              fontFamily: 'PT Sans Caption',
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
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
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
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Text(
                      "Войти",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'PT Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
