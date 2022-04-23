import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/user/cubit/user_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'landscape.dart';
import 'portrait.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc(userRepository: RepositoryProvider.of<UserRepository>(context))),
            BlocProvider(create: (context) => UserCubit(context.read<UserRepository>())),
          ], //children могут иметь доступ к LoginBloc
            child: OrientationBuilder(
                builder: (context, orientation) =>
                    orientation == Orientation.portrait
                        ? Portrait()
                        : Landscape())));
  }
}
