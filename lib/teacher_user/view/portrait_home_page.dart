import 'package:flutter/material.dart';
import 'package:ptk_inventory/classroom_equipment/view/equipment_classrooms_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/repair_page.dart';
import 'package:ptk_inventory/user_profile/view/my_profile.dart';

class PortraitReaderPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PortraitReaderPage());
  }

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
              child: userProfileView(context),
            ),
          );
        },
      ),
    );
  }
}

Widget userProfileView(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                  child: Text(
                    "Меню",
                    style: TextStyle(
                      color: blackLabels,
                      fontFamily: 'Rubik',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                myEquipmentCard(context),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 54 + 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                profileCard(context),
                repairCard(context),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget profileCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(UserProfilePage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        elevation: 7.0,
        shadowColor: greyShadow,
        color: blueCustom,
        child: const Padding(
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

Widget repairCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(RepairPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        elevation: 7.0,
        shadowColor: greyShadow,
        color: orangeCustom,
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
    ),
  );
}

Widget myEquipmentCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(ClassroomsEquipmentPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        elevation: 7.0,
        shadowColor: greyShadow,
        color: redCustom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Моё оборудование",
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
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                "Все оборудование по аудиториям и его характеристики",
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
    ),
  );
}
