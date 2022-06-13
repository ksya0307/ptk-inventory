import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/repository/repair_repository.dart';
import 'package:ptk_inventory/repair/view/add_repair/add_repair_page.dart';
import 'package:ptk_inventory/repair/view/repair_form.dart';

class RepairPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RepairPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RepairBloc(repairRepository: RepairRepository()),
        ),
        BlocProvider(
          create: (context) => ClassroomEquipmentBloc(
            classroomEquipmentRepository: ClassroomEquipmentRepository(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              ClassroomBloc(classroomRepository: ClassroomRepository()),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(categoryRepository: CategoryRepository()),
        )
      ],
      child: Scaffold(
        floatingActionButton: BlocBuilder<RepairBloc, RepairState>(
          builder: (context, state) {
            return FloatingActionButton(
              tooltip: "Добавить акт приема-передачи",
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<RepairBloc>.value(
                        value: context.read<RepairBloc>(),
                      ),
                      BlocProvider<ClassroomEquipmentBloc>.value(
                        value: context.read<ClassroomEquipmentBloc>(),
                      ),
                      BlocProvider<ClassroomBloc>.value(
                        value: context.read<ClassroomBloc>(),
                      ),
                      BlocProvider<CategoryBloc>.value(
                        value: context.read<CategoryBloc>(),
                      )
                    ],
                    child: AddRepairPage(),
                  ),
                ),
              ),
            );
          },
        ),
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
          centerTitle: true,
          title: const Text(
            "Акты приема-передачи",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints view) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: view.maxHeight,
                  ),
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state.user.role == UserRole.teacher) {
                        BlocProvider<RepairBloc>.value(
                          value: context.read<RepairBloc>()
                            ..add(const RepairUserLoadList()),
                          child: const RepairForm(),
                        );
                      } else {
                        BlocProvider<RepairBloc>.value(
                          value: context.read<RepairBloc>()
                            ..add(
                              const RepairLoadList(),
                            ),
                          child: const RepairForm(),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        child: Column(
                          children: const [
                            RepairForm(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
