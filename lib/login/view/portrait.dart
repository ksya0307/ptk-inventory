import 'package:flutter/material.dart';
import 'package:ptk_inventory/login/view/login_form.dart';
import 'package:ptk_inventory/login/view/logo_widget.dart';

class Portrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints view) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: view.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MainLogo(),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
