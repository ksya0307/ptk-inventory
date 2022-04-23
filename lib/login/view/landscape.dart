import 'package:flutter/material.dart';
import 'login_form.dart';
import 'logo_widget.dart';

class Landscape extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        LayoutBuilder(builder: (BuildContext context, BoxConstraints view) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: view.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                              child: MainLogo())
                        ],
                      ),
                    ),
                    Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  LoginForm()
                                ],
                              )),
                        ),
                  ],
                ),
              )));
    }));
  }
}
