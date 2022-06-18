import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/add_specs/add_specs_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_form.dart';

class SpecsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SpecsPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClassroomEquipmentBloc(
            classroomEquipmentRepository: ClassroomEquipmentRepository(),
          )..add(const ClassroomEquipmentLoadSpecs()),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(categoryRepository: CategoryRepository())
                ..add(const CategoryLoadList()),
        ),
      ],
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
          builder: (context, state) {
            return FloatingActionButton(
              tooltip: "Добавить оборудование",
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ClassroomEquipmentBloc>.value(
                        value: context.read<ClassroomEquipmentBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<CategoryBloc>()
                          ..add(const CategoryLoadList()),
                      ),
                    ],
                    child: AddSpecsPage(),
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
            "Оборудование",
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
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: const [
                        SpecsForm(
                          notFound: false,
                          firstFlexRow: 2,
                          secondFlexRow: 5,
                          firstFlex: 2,
                          secondFlex: 5,
                        ),
                      ],
                    ),
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
