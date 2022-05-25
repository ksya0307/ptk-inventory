import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Загрузка ресурсов...",
                style: TextStyle(
                  color: greyDark,
                  fontFamily: 'Rubik',
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
