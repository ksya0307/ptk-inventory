import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/equipment_classrooms_form.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';

class ClassroomsEquipmentPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ClassroomsEquipmentPage(),
    );
  }

  @override
  State<ClassroomsEquipmentPage> createState() =>
      _EquipmentClassroomsPageState();
}

class _EquipmentClassroomsPageState extends State<ClassroomsEquipmentPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ClassroomBloc(classroomRepository: ClassroomRepository()),
        ),
        BlocProvider(
          create: (context) => ClassroomEquipmentBloc(
            classroomEquipmentRepository: ClassroomEquipmentRepository(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(categoryRepository: CategoryRepository())..add(const CategoryLoadList()),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: state.user.role == UserRole.admin ||
                    state.user.role == UserRole.moderator
                ? FloatingActionButton(
                    tooltip: "???????????????? ????????????????????????",
                    child: const Icon(Icons.add_rounded),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider<ClassroomEquipmentBloc>.value(
                              value: context.read<ClassroomEquipmentBloc>()
                                ..add(
                                  const ClassroomEquipmentSelectedClassroom(
                                    null,
                                  ),
                                ),
                            ),
                            BlocProvider.value(
                              value: context.read<CategoryBloc>()
                                ..add(const CategorySelected(null)),
                            ),
                            BlocProvider.value(
                              value: context.read<ClassroomBloc>()
                                ..add(const ClassroomSelected(null)),
                            )
                          ],
                          child: AddEquipmentPage(),
                        ),
                      ),
                    ),
                  )
                : null,
            appBar: AppBar(
              leading: IconButton(
                tooltip: "??????????",
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 0,
              title: Text(
                state.user.role == UserRole.admin ||
                        state.user.role == UserRole.moderator
                    ? "????????????????????????"
                    : "?????? ????????????????????????",
                style: const TextStyle(
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
                        minHeight: view.maxHeight,
                      ),
                      child: const EquipmentClassroomForm(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
