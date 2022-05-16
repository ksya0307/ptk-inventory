import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class ClassroomsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ClassroomsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Аудитории',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: classroomView(),
    );
  }
}

Widget classroomView() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
    child: Column(children: const [ClassroomTeacherSearch()]),
  );
}

class ClassroomTeacherSearch extends StatefulWidget {
  const ClassroomTeacherSearch({Key? key}) : super(key: key);

  @override
  State<ClassroomTeacherSearch> createState() => _ClassroomTeacherSearchState();
}

class _ClassroomTeacherSearchState extends State<ClassroomTeacherSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          labelStyle: TextStyle(fontFamily: 'Rubik', fontSize: 18),
          errorStyle: TextStyle(
            color: redCustom,
            fontFamily: 'Rubik',
          ),
          hintText: 'Фамилия, № аудитории',
          contentPadding: EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
          hintStyle: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: greyDark,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
