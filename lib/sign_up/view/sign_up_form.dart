import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/login/login.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _signUpForm(context),
    );
  }
}

Widget _signUpForm(BuildContext context) {
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
            child: _SurnameInput(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _NameInput(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _PatronymicInput(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _UsernameInput(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _PasswordInput(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: _SignUpButton(),
          )
        ],
      ),
    ),
  );
}

class _SurnameInput extends StatefulWidget {
  const _SurnameInput({Key? key}) : super(key: key);

  @override
  State<_SurnameInput> createState() => __SurnameInputState();
}

class __SurnameInputState extends State<_SurnameInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class _NameInput extends StatefulWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  State<_NameInput> createState() => __NameInputState();
}

class __NameInputState extends State<_NameInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

class _PatronymicInput extends StatelessWidget {
  const _PatronymicInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    return TextFormField(
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
    return TextFormField(
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
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
        onPressed: () {},
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
  }
}
