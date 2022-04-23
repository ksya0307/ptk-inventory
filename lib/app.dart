import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/login/bloc/login_bloc.dart';
import 'package:ptk_inventory/ui/palette.dart';
import 'package:ptk_inventory/user/cubit/user_cubit.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:user_repository/user_repository.dart';
import 'inventory/Inventory_page.dart';
import 'login/view/login_page.dart';

///отвечает за создание и предоставление AuthBloc, который используется AppView
//это разделение на две части облегчет тестирование
class App extends StatelessWidget {
  const App({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return
        //репозиторий для всего приложения, который на слое чуть выше будет полезен
        RepositoryProvider.value(
            value: _userRepository,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => UserCubit(_userRepository)),
                BlocProvider(
                    create: (context) => LoginBloc(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context))),
              ],
              child: AppView(),
            ));
  }
}

class AppView extends StatefulWidget {
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return FlowBuilder<AuthenticationStatus>(
          state: context.select((value) => ),
          //чтоб понять какой статус и зависимо от него куда будем переходить
          // listener: (context, state) {
          //   switch (state.authenticationStatus) {
          //     case AuthenticationStatus.authenticated:
          //       _navigator.pushAndRemoveUntil<void>(
          //           InventoryPage.route(), (route) => false);
          //       break;
          //     case AuthenticationStatus.unauthenticated:
          //       _navigator.pushAndRemoveUntil<void>(
          //           LoginPage.route(), (route) => false);
          //       break;
          //     default:
          //       break;
          //   }
          //   if (state == AuthenticationStatus.authenticated) {
          //   } else {
          //     log('неправильный логин или пароль');
          //   }
          // },
          // child: child,
        );
      },
      onGenerateRoute: (_) => LoginPage.route(),
      title: 'PTK Inventory',
      theme: ThemeData(
          primarySwatch: Palette.customBlue,
          primaryColor: const Color.fromRGBO(0, 47, 167, 1.0),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
              headline6: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'PT Sans Caption')),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromRGBO(0, 47, 167, 1.0))),
    );
  }
}
