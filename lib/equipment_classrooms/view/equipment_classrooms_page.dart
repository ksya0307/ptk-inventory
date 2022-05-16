import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/equipment_classrooms/add_equipment/view/add_equipment_page.dart';

class EquipmentClassroomsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => EquipmentClassroomsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var title = "";
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            if (state.user.role == UserRole.reader) {
              title = "Моё оборудование";
            }
            if (state.user.role == UserRole.admin) title = "Оборудование";
            if (state.user.role == UserRole.moderator) title = "Оборудование";
            break;
          case AuthenticationStatus.unauthenticated:
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: "Назад",
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          title: const Text(
            "Оборудование",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints view) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: view.minWidth,
                  ),
                  child: equipmentClassrooms(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget equipmentClassrooms(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Classroom(),
        const Equipment(),
        const EquipmentSearch(),
        addEquipmentLabel(context)
      ],
    ),
  );
}

Widget addEquipmentLabel(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: GestureDetector(
      onTap: () => Navigator.of(context).push(AddEquipmentPage.route()),
      child: const SizedBox(
        height: 48,
        child: Text(
          "Добавить",
          style: TextStyle(
            color: primaryBlue,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

class Classroom extends StatefulWidget {
  const Classroom({Key? key}) : super(key: key);

  @override
  State<Classroom> createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: greyCard,
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Аудитория",
              style: TextStyle(
                color: blackLabels,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            // Flex(direction: Axis.vertical, children: [
            //   CustomDropdown(
            //     labelText: "Выбрать",
            //     dropDownWidget: DropdownButton<String>(
            //       // value: '1',
            //       isExpanded: true,
            //       icon: Icon(Icons.arrow_drop_down_rounded),
            //       items:
            //           <String>['100', '101', '102', '103'].map((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //       onChanged: (_) {},
            //     ),
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }
}

class Equipment extends StatefulWidget {
  const Equipment({Key? key}) : super(key: key);

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Оборудование",
                style: TextStyle(
                  color: blackLabels,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              // Flex(direction: Axis.vertical, children: [
              //   CustomDropdown(
              //     labelText: "Выбрать",
              //     dropDownWidget: DropdownButton<String>(
              //       // value: '1',
              //       isExpanded: true,
              //       icon: Icon(Icons.arrow_drop_down_rounded),
              //       items:
              //           <String>['100', '101', '102', '103'].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //       onChanged: (_) {},
              //     ),
              //   ),
              // ]),
            ],
          ),
        ),
      ),
    );
  }
}

class EquipmentSearch extends StatefulWidget {
  const EquipmentSearch({Key? key}) : super(key: key);

  @override
  State<EquipmentSearch> createState() => EquipmentSearchState();
}

class EquipmentSearchState extends State<EquipmentSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
            hintText: '1234567890',
            contentPadding: EdgeInsets.fromLTRB(12, 12 + 3, 12, 12 + 3),
            hintStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: greyDark,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
