import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('images/logo.png'), context);
    return const Image(
      image: AssetImage('images/logo.png'),
    );
  }
}
