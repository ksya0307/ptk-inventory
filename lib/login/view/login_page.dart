import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.screenStatus == LoginStatus.unverified) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Неверное имя пользователя или пароль'),
                ),
              );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) =>
                  orientation == Orientation.portrait
                      ? Portrait()
                      : Landscape(),
            ),
          );
        },
      ),
    );
  }
}

    // BlocListener<LoginBloc, LoginState>(
    //   listener: (context, state) {
    //     if (state.loginStatus == LoginStatus.verified) {
    //       Navigator.popAndPushNamed(context, RouteName.inventoryPage);
    //     }
    //   },
    //   child: Scaffold(
    //     body: BlocProvider(
    //       create: (context) => LoginBloc(
    //         userRepository: RepositoryProvider.of<UserRepository>(context),
    //       ),
    //       //children могут иметь доступ к LoginBloc
    //       child: OrientationBuilder(
    //         builder: (context, orientation) =>
    //             orientation == Orientation.portrait ? Portrait() : Landscape(),
    //       ),
    //     ),
    //   ),
    // );
