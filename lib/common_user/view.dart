import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/user_profile/view/my_profile.dart';

class CommonPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CommonPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return RefreshIndicator(
              color: primaryBlue,
              backgroundColor: greyCard,
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: const _CommonView(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 5));
  }
}

class _CommonView extends StatelessWidget {
  const _CommonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "В ближайшее время здесь появится больше возможностей",
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 12, top: 8),
          child: Text(
            "Пожалуйста, ожидайте",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: ElevatedButton(
            key: const Key('account_continue_raisedButton'),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(primaryBlue),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return UserProfilePage();
                  },
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                "Профиль",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
