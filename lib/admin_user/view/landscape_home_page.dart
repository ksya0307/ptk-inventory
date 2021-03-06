import 'package:flutter/material.dart';

import 'package:ptk_inventory/category/view/category_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/equipment_classrooms_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_page.dart';
import 'package:ptk_inventory/classrooms/view/classroom_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/view/document_page.dart';
import 'package:ptk_inventory/ifo/view/ifo_page.dart';
import 'package:ptk_inventory/repair/view/repair_page.dart';
import 'package:ptk_inventory/user_profile/view/my_profile.dart';
import 'package:ptk_inventory/users/view/users_page.dart';

class LandscapeAdminPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LandscapeAdminPage());
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
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 2),
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
                usersCard(context),
                equipmentCard(context),
                specs(context),
                classroomsCard(context),
                documentsCard(context),
                ifosCard(context),
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
                profileCard(context),
                inventoryManagementCard(context),
                repairCard(context),
                commentsCard(context),
                categoriesCard(context)
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget specs(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(SpecsPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Характеристики оборудования",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: blueCustom,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget inventoryManagementCard(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Учет оборудования",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
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
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
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
                  color: blueCustom,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                "Акты приема-передачи оборудования",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: blueCustom,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget classroomsCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(ClassroomsPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Аудитории",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget commentsCard(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Комментарии",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget categoriesCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(CategoryPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Категории оборудования",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget profileCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(UserProfilePage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Профиль",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget equipmentCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(ClassroomsEquipmentPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
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
                  color: blueCustom,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                "Все оборудование в колледже",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: blueCustom,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget usersCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(UsersPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.18,
      child: const Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            "Пользователи",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blueCustom,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget documentsCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(DocumentsPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Документы",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: blueCustom,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                "Договора, контракты",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: blueCustom,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ifosCard(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(IfoPage.route()),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        elevation: 2.0,
        shadowColor: greyShadow,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "ИФО",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: blueCustom,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                "Источники финансового обеспечения",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: blueCustom,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
