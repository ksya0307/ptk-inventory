import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/view/add_repair/add_repair_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_form.dart';

class AddRepairPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddRepairPage());
  }

  @override
  State<AddRepairPage> createState() => _AddRepairPageState();
}

class _AddRepairPageState extends State<AddRepairPage> {
  @override
  Widget build(BuildContext context) {
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
            context.read<RepairBloc>().add(const RepairEquipmentChanged(null));
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return IconButton(
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
                      return state.user.role == UserRole.teacher
                          ? BlocProvider<ClassroomEquipmentBloc>.value(
                              value: BlocProvider.of<ClassroomEquipmentBloc>(
                                context,
                              )..add(
                                  const ClassroomEquipmentLoadUserEquipmentsList(),
                                ),
                              child: EquipmentFilterSheet(
                                initialChildSize: 0.7,
                                minChildSize: 0.5,
                                maxChildSize: 0.95,
                                onTap: () {
                                  context.read<ClassroomEquipmentBloc>().add(
                                        const ClassroomEquipmentFilteredEquipment(
                                          null,
                                        ),
                                      );
                                  Navigator.of(context).pop();
                                },
                                widget: Column(
                                  children: [
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
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                    const ClassroomEquipmentForm(
                                      firstFlexRow: 3,
                                      secondFlexRow: 5,
                                      firstFlex: 3,
                                      secondFlex: 5,
                                      widget: SizedBox(),
                                    ),
                                  ],
                                ),
                                title: 'Фильтр',
                              ),
                            )
                          : MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<ClassroomBloc>()
                                    ..add(
                                      const ClassroomLoadList(),
                                    ),
                                ),
                                BlocProvider.value(
                                  value: context.read<ClassroomEquipmentBloc>(),
                                ),
                              ],
                              child: EquipmentFilterSheet(
                                title: 'Фильтр',
                                initialChildSize: 0.7,
                                minChildSize: 0.5,
                                maxChildSize: 0.95,
                                onTap: () {
                                  context.read<ClassroomEquipmentBloc>().add(
                                        const ClassroomEquipmentFilteredEquipment(
                                          null,
                                        ),
                                      );
                                  Navigator.of(context).pop();
                                },
                                widget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const PropertyLabel(
                                      property: 'Аудитория',
                                      bottomPadding: 4,
                                    ),
                                    SearchField(
                                      hintText: '102',
                                      keyboardType: TextInputType.text,
                                      inputFormatters: const [],
                                      onChange: (classroom) {
                                        context.read<ClassroomBloc>().add(
                                              ClassroomSearch(
                                                matchingWord: classroom,
                                              ),
                                            );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const FilterClassroomForm(
                                      bloc: ClassroomEquipmentBloc,
                                      bottomPadding: 16,
                                    ),
                                    const ClassroomEquipmentForm(
                                      widget: SizedBox(height: 0),
                                      firstFlexRow: 3,
                                      secondFlexRow: 7,
                                      firstFlex: 3,
                                      secondFlex: 7,
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
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
                  minHeight: view.minHeight,
                  minWidth: view.maxWidth,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
  }
}
