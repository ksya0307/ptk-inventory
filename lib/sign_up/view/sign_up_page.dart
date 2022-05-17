import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/sign_up/bloc/sign_up_bloc.dart';
import 'package:ptk_inventory/sign_up/repository/sign_up_repository.dart';
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
  void initState() {
    print("INIT");
    super.initState();
  }

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
                  create: (_) =>
                      SignUpBloc(signUpRepository: SignUpRepository()),
                  child: BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) => print("STATE $state"),
                      child: const SignUpForm()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
