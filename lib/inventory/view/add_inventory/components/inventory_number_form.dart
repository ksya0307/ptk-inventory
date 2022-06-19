import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';

import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/inventory_number_list.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_list.dart';

class InventoryNumberForm extends StatelessWidget {
  const InventoryNumberForm({
    Key? key,
    this.bottomPadding = 0,
    required this.bloc,
  }) : super(key: key);
  final double bottomPadding;
  final Type bloc;

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
                              "Загрузка инвентарных номеров...",
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
              return InventoryNumberList(
                bloc: bloc,
                bottomPadding: bottomPadding,
              );
            }
            if (state.classroomEquipmentLoadingStatus ==
                    ClassroomEquipmentLoadingStatus.loadingSuccess &&
                state.globalEquipments.isEmpty) {
              return const Text("Список аудиторий пуст");
            }

            return const Text("Что-то пошло не так");
          },
        ),
      ],
    );
  }
}
