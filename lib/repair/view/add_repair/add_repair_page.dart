import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/repository/classroom_repository.dart';
import 'package:ptk_inventory/common/component/apply_filter_label.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/add_repair_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_form.dart';

class AddRepairPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddRepairPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                tooltip: "Назад",
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: primaryBlue,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt_rounded,
                    color: primaryBlue,
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return BlocProvider<ClassroomEquipmentBloc>.value(
                          value: BlocProvider.of<ClassroomEquipmentBloc>(
                            context,
                          )..add(
                              const ClassroomEquipmentLoadUserEquipmentsList(),
                            ),
                          child: EquipmentFilterSheet(
                            onTap: () {
                              print("close");
                              context.read<ClassroomEquipmentBloc>().add(
                                    const ClassroomEquipmentFilteredEquipment(
                                      null,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                            widget: Column(
                              children: [
                                BlocProvider.value(
                                  value: context.read<ClassroomBloc>(),
                                  child: const ChooseClassroom(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                BlocProvider.value(
                                  value: context.read<CategoryBloc>(),
                                  child: const ChooseCategory(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                BlocBuilder<ClassroomEquipmentBloc,
                                    ClassroomEquipmentState>(
                                  buildWhen: (previous, current) =>
                                      previous.visibleList !=
                                      current.visibleList,
                                  builder: (context, state) {
                                    return SearchField(
                                      hintText: '101340003313',
                                      keyboardType: TextInputType.text,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChange: (inventoryNumber) => {
                                        context
                                            .read<ClassroomEquipmentBloc>()
                                            .add(
                                              ClassroomEquipmentSearch(
                                                inventoryNumber,
                                              ),
                                            ),
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                BlocBuilder<ClassroomEquipmentBloc,
                                    ClassroomEquipmentState>(
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          ApplyFilterLabel(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const ClassroomEquipmentForm(),
                              ],
                            ),
                            title: 'Фильтр',
                          ),
                        );
                      },
                    );
                  },
                )
              ],
              title: const Text(
                "Акт приема-передачи",
                style: TextStyle(
                  color: primaryBlue,
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: BlocProvider.value(
              value: context.read<ClassroomEquipmentBloc>(),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints view) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: view.maxHeight,
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AddRepairForm(),
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
        },
      ),
    );
  }
}
