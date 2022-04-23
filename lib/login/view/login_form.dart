import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/login/login.dart';
import 'package:ptk_inventory/user/cubit/user_cubit.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.status.isFailure) {
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
          _UsernameInput(),
          SizedBox(height: 16),
          _PasswordInput(),
          SizedBox(height: 16),
          _LoginButton(),
          SizedBox(height: 16),
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

  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose(){
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextFormField(
            controller: _usernameController,
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            cursorColor: Theme
                .of(context)
                .primaryColor,
            maxLines: 1,
            minLines: 1,
            style: const TextStyle(
                fontFamily: 'PT Sans Caption',
                fontSize: 18,
                color: Color.fromRGBO(68, 68, 68, 1.0)),
            decoration: InputDecoration(
              labelText: 'Логин',

              ///errorText
              errorText: state.username.invalid
                  ? 'Логин не может быть пустым'
                  : null,
              suffixIcon: const Icon(
                Icons.login_rounded,
                color: Color.fromRGBO(156, 156, 156, 1.0),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              hintStyle: const TextStyle(
                  fontFamily: 'PT Sans Caption',
                  fontSize: 18,
                  color: Color.fromRGBO(150, 150, 150, 1.0)),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
            ),
          );
        });
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => PasswordInput();

}

class PasswordInput extends State<_PasswordInput> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
              controller: _passwordController,
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              cursorColor: Theme
                  .of(context)
                  .primaryColor,
              maxLines: 1,
              minLines: 1,
              obscureText: _obscureText,
              style: TextStyle(
                  fontFamily: 'PT Sans Caption',
                  fontSize: 18,
                  color: Color.fromRGBO(68, 68, 68, 1.0)),
              decoration: InputDecoration(
                labelText: 'Пароль',
                errorText:
                state.password.invalid ? 'Пароль не может быть пустым' : null,
                suffixIcon: IconButton(
                  color: Color.fromRGBO(156, 156, 156, 1.0),
                  onPressed: _passwordVisibility,

                  icon: Icon(!_obscureText ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                hintStyle: const TextStyle(
                    fontFamily: 'PT Sans Caption',
                    fontSize: 18,
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
                border: const OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.circular(7.0)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.circular(7.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                    borderRadius: BorderRadius.circular(7.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                    borderRadius: BorderRadius.circular(7.0)),
              ));
        });
  }
}


class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              child: ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: const Text("Войти",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'PT Sans',
                            fontWeight: FontWeight.w700))),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0))),
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor:
                    MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Color.fromRGBO(255, 255, 255, 0.65);
                      }
                      return Colors.white;
                    }),
                    backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Color.fromRGBO(0, 47, 167, 0.65);
                      }
                      return Color.fromRGBO(0, 47, 167, 1.0);
                    })),
                onPressed: state.status.isValidated
                    ? () {
                  context
                      .read<UserCubit>().fetchUser(state.username.value, state.password.value);
                }
                    : null,
              ));
        });
  }
}
