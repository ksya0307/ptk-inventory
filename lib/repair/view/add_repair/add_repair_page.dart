import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/repository/classroom_equipment_repository.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/add_repair_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/apply_filter_button.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/common/apply_filter_label.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/common/search_field.dart';

class AddRepairPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddRepairPage());
  }

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );

    return BlocProvider(
      create: (context) => ClassroomEquipmentBloc(
        classroomEquipmentRepository: ClassroomEquipmentRepository(),
      ),
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
                          child: makeDismissible(
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.7,
                              minChildSize: 0.5,
                              maxChildSize: 0.95,
                              builder: (_, controller) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ListView(
                                    shrinkWrap: true,
                                    controller: controller,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          16,
                                          16,
                                          24,
                                        ),
                                        child: Flex(
                                          mainAxisSize: MainAxisSize.min,
                                          direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 24,
                                                  ),
                                                  child: Flex(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Navigator.of(
                                                          context,
                                                        ).pop(),
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_back_rounded,
                                                          color: primaryBlue,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Flex(
                                                          direction:
                                                              Axis.horizontal,
                                                          children: const [
                                                            Spacer(),
                                                            Text(
                                                              "Фильтр",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color:
                                                                    primaryBlue,
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const ChooseClassroom(),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const ChooseCategory(),
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
                                                  keyboardType:
                                                      TextInputType.text,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChange: (inventoryNumber) =>
                                                      {
                                                    context
                                                        .read<
                                                            ClassroomEquipmentBloc>()
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
                                            InkWell(
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
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const ClassroomEquipmentForm(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
            body: SafeArea(
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
          );
        },
      ),
    );
  }
}
