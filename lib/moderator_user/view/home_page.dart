import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/user/view/my_profile.dart';

class ModeratorPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ModeratorPage());
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
                  minHeight: view.minWidth,
                ),
                child: UserProfileView(context),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget UserProfileView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24, left: 10, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                  child: Text(
                    "Меню",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: blackLabels,
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ProfileCard(context),
                EquipmentCard(context),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 54 + 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                InventoryManagementCard(context),
                RepairCard(context),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget RepairCard(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.47,
    height: MediaQuery.of(context).size.height * 0.25,
    child: Card(
      elevation: 2.0,
      color: const Color.fromRGBO(240, 150, 58, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Ремонт",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Составление акта приема-передачи оборудования в ремонт",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ProfileCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(UserProfilePage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.25,
      child: const Card(
        elevation: 2.0,
        color: Color.fromRGBO(63, 138, 251, 1.0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Профиль",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget InventoryManagementCard(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.25,
      child: const Card(
        elevation: 2.0,
        color: Color.fromRGBO(109, 18, 175, 1.0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Учет оборудования",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget EquipmentCard(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.47,
    height: MediaQuery.of(context).size.height * 0.25,
    child: Card(
      elevation: 2.0,
      color: redCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Оборудование",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Все оборудование в колледже",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
