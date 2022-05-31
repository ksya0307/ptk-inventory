import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/login/view/landscape.dart';
import 'package:ptk_inventory/login/view/portrait.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.status == AuthenticationStatus.unauthenticated) {
                snackbarMessageCommonError(
                    context, "Неверный логин или пароль");
              }
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.formStatus == FormzStatus.submissionFailure) {
                snackbarMessageCommonError(
                    context, "Неверный логин или пароль");
              }
            },
          ),
        ],
        child: Scaffold(
          body: OrientationBuilder(
            builder: (context, orientation) =>
                orientation == Orientation.portrait ? Portrait() : Landscape(),
          ),
        ),
      ),
    );
  }
}
