import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/classrooms/view/classroom_form.dart';

class ClassroomsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ClassroomsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ClassroomBloc(classroomRepository: ClassroomRepository())
            ..add(const ClassroomLoadList()),
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
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: const ClassroomForm(),
        ),
      ),
    );
  }
}
