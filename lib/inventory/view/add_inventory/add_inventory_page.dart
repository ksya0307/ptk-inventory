import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/repository/document_repository.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/repository/ifo_repository.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/add_inventory_form.dart';

class AddInventoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddInventoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClassroomEquipmentBloc(
            classroomEquipmentRepository: ClassroomEquipmentRepository(),
          )..add(const ClassroomEquipmentNotInInventory()),
        ),
        BlocProvider(
          create: (context) =>
              ClassroomBloc(classroomRepository: ClassroomRepository())
                ..add(const ClassroomLoadList()),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(categoryRepository: CategoryRepository()),
        ),
        BlocProvider(
          create: (context) =>
              DocumentBloc(documentRepository: DocumentRepository())
                ..add(const DocumentLoadList()),
        ),
        BlocProvider(
          create: (context) =>
              IfoBloc(ifoRepository: IfoRepository())..add(const IfoLoadList()),
        )
      ],
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
            'Принять к учету',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: AddInventoryForm(),
      ),
    );
  }
}
