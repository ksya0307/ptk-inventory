import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/admin_user/view/home_page.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/common/repository/user_repository.dart';
import 'package:ptk_inventory/common_user/view.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/inventory/view/Inventory_page.dart';
import 'package:ptk_inventory/login/view/login_page.dart';
import 'package:ptk_inventory/moderator_user/view/home_page.dart';
import 'package:ptk_inventory/palette.dart';
import 'package:ptk_inventory/reader_user/view/home_page.dart';
import 'package:ptk_inventory/splash/splash.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
    required this.authenticationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) {
          return AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          );
        },
        child: const AppView(),
      ),
    );
  }

  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

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
      title: 'PTK Inventory',
      theme: ThemeData(
        primarySwatch: Palette.customBlue,
        primaryColor: primaryBlue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Rubik',
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryBlue,
          selectionColor: blueCustom,
          selectionHandleColor: primaryBlue,
        ),
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            print('state: ${state.user}');
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                print(state.user.role);
                if (state.user.role == UserRole.reader) {
                  _navigator.pushAndRemoveUntil<void>(
                    ReaderPage.route(),
                    (route) => false,
                  );
                }
                if (state.user.role == UserRole.admin) {
                  _navigator.pushAndRemoveUntil<void>(
                    AdminPage.route(),
                    (route) => false,
                  );
                }
                if (state.user.role == UserRole.moderator) {
                  _navigator.pushAndRemoveUntil<void>(
                    ModeratorPage.route(),
                    (route) => false,
                  );
                }
                if (state.user.role == UserRole.common) {
                  //if role == UserRole.common
                  _navigator.pushAndRemoveUntil<void>(
                    InventoryPage.route(),
                    (route) => false,
                  );
                }

                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
