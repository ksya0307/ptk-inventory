import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     Builder(
        //       builder: (context) {
        //         final name = context.select(
        //           (AuthenticationBloc bloc) => bloc.state.user.name,
        //         );
        //         return Text('Name: $name');
        //       },
        //     ),
        //     ElevatedButton(
        //         onPressed: () {
        //           context
        //               .read<AuthenticationBloc>()
        //               .add(AuthenticationLogoutRequested());
        //         },
        //         child: const Text('Log Out'))
        //   ],
        // ),
      ),
    );
  }
}
