import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/sign_up/bloc/sign_up_bloc.dart';
import 'package:ptk_inventory/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage());
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: BlocProvider(
                  create: (_) => SignUpBloc(userUpRepository: UserRepository()),
                  child: BlocListener<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state.formStatus == FormzStatus.submissionSuccess) {
                        snackbarMessage(
                          context,
                          "Вы успешно зарегистировались!",
                        );
                        Navigator.of(context).pop();
                      } else if (state.formStatus ==
                          FormzStatus.submissionFailure) {
                        snackbarMessage(
                          context,
                          "Такой логин уже существует",
                        );
                      }
                    },
                    child: const SignUpForm(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
