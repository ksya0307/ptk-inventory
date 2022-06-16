import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_list.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/view/ifo_list.dart';

class SpecsForm extends StatelessWidget {
  const SpecsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
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
              builder: (context, state) {
                if (state.classroomEquipmentLoadingStatus ==
                    ClassroomEquipmentLoadingStatus.loadingInProgress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
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
                if (state.classroomEquipmentLoadingStatus == ClassroomEquipmentLoadingStatus.loadingSuccess &&
                    state.globalSpecs.isNotEmpty) {
                  
                  return const SpecsList();
                }
                if (state.classroomEquipmentLoadingStatus == ClassroomEquipmentLoadingStatus.loadingSuccess &&
                    state.globalSpecs.isEmpty) {
                  return const Text("Список оборудования пуст");
                }

                return const Text("Что-то пошло не так");
              },
            ),
          ),
        ],
      ),
    );
  }
}
