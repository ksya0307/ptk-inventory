import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

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
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            onChanged: (password) =>
                context.read<UsersBloc>().add(UsersPasswordChanged(password)),
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
                  ? 'Длина должна быть не менее 8 символов'
                  : null,
              errorStyle: const TextStyle(
                color: redCustom,
                fontFamily: 'Rubik',
              ),
              hintText: "Новый пароль",
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
                  color: blueCustom,
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
          ),
        );
      },
    );
  }
}
