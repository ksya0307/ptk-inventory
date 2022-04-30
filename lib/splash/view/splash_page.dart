import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/logo.png'), context);
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            Text(
              'PTK Inventory',
              style: TextStyle(color: Colors.amber),
            )
          ],
        ),
      ),
    );
  }
}
