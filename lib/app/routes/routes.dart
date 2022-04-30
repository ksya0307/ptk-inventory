// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ptk_inventory/app/routes/route_names.dart';
// import 'package:ptk_inventory/home/view/home_page.dart';
// import 'package:ptk_inventory/inventory/Inventory_page.dart';
// import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
// import 'package:ptk_inventory/login/login.dart';
// import 'package:ptk_inventory/splash/splash.dart';

// class AppRoutes {
//   Route onGenerate(RouteSettings settings) {
//     switch (settings.name) {
//       case RouteName.loginPage:
//         return MaterialPageRoute(builder: (_) {
//           return BlocProvider<LoginBloc>(
//             create: (context) => LoginBloc(userRepository: UserRepository()),
//             child: const LoginPage(),
//           );
//         });
//       case RouteName.inventoryPage:
//         return MaterialPageRoute(builder: (_) {
//           return BlocProvider<InventoryBloc>(
//             create: (context) => InventoryBloc(),
//             child: InventoryPage(),
//           );
//         });
//       case RouteName.homePage:
//         return MaterialPageRoute(builder: (_) {
//           return BlocProvider<LoginBloc>(
//             create: (context) => LoginBloc(userRepository: UserRepository()),
//             child: HomePage(),
//           );
//         });
//       default:
//         return MaterialPageRoute(builder: (_) => SplashPage());
//     }
//   }
// }


// List<Page> onGenerateAppViewPages(AuthenticationStatus state, List<Page<dynamic>> pages){
//   switch(state){
//     case AuthenticationStatus.authenticated:
//       return
//     case AuthenticationStatus.unauthenticated: return [LoginPage.page()];
//   }
// }
