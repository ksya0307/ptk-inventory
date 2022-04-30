import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Reader'),
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
