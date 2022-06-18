import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_list.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';

class SpecsForm extends StatelessWidget {
  const SpecsForm({
    Key? key,
    this.widget,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
    this.notFound,
  }) : super(key: key);
  final Widget? widget;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  final bool? notFound;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchField(
          hintText: 'Microtik',
          keyboardType: TextInputType.text,
          inputFormatters: const [],
          onChange: (specs) => {
            context.read<ClassroomEquipmentBloc>().add(
                  ClassroomEquipmentSpecsSearch(matchingWord: specs),
                ),
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.globalSpecs != current.globalSpecs,
            builder: (context, state) {
              if (state.classroomEquipmentLoadingStatus ==
                  ClassroomEquipmentLoadingStatus.loadingInProgress) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                "Загрузка оборудования...",
                                style: TextStyle(
                                  color: greyDark,
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state.classroomEquipmentLoadingStatus ==
                      ClassroomEquipmentLoadingStatus.loadingSuccess &&
                  state.globalSpecs.isNotEmpty) {
                return SpecsList(
                  notFound: notFound,
                  firstFlexRow: firstFlexRow,
                  secondFlexRow: secondFlexRow,
                  firstFlex: firstFlex,
                  secondFlex: secondFlex,
                  radioButton: widget,
                );
              }
              if (state.classroomEquipmentLoadingStatus ==
                      ClassroomEquipmentLoadingStatus.loadingSuccess &&
                  state.globalSpecs.isEmpty) {
                return const Text("Список оборудования пуст");
              }

              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Выберите категорию в фильтре, чтобы посмотреть список характеристик оборудования",
                  style: TextStyle(
                    color: greySteps,
                    fontFamily: 'Rubik',
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
