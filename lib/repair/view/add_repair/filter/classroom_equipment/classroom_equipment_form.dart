import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_list.dart';

class ClassroomEquipmentForm extends StatelessWidget {
  const ClassroomEquipmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
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
                state.globalEquipments.isNotEmpty) {
              // print("${state.visibleList}");
              return const ClassroomEquipmentList();
            }
            if (state.classroomEquipmentLoadingStatus ==
                    ClassroomEquipmentLoadingStatus.loadingSuccess &&
                state.globalEquipments.isEmpty) {
              return const Text("Список оборудования пуст");
            }

            return const Text("Что-то пошло не так");
          },
        ),
      ],
    );
  }
}
