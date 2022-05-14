import 'package:flutter/material.dart';
import 'package:ptk_inventory/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: const SignUpForm(),
              ),
            );
          },
        ),
      ),
    );
  }
}
