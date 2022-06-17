import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/update_specs/update_specs_form.dart';

class UpdateSpecsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UpdateSpecsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: "Назад",
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<ClassroomEquipmentBloc>().add(
                      const ClassroomEquipmentSpecsSelected(
                        null,
                      ),
                    );
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Изменение оборудования",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          UpdateSpecsForm(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
