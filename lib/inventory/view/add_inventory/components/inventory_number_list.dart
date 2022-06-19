import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/visible_list_inventory_number.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_visible_list.dart';

class InventoryNumberList extends StatefulWidget {
  const InventoryNumberList({
    Key? key,
    this.bottomPadding = 0,
    required this.bloc,
  }) : super(key: key);
  final double bottomPadding;
  final Type bloc;
  @override
  State<InventoryNumberList> createState() => _InventoryNumberListState();
}

class _InventoryNumberListState extends State<InventoryNumberList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final inventoryNumbers = state.globalEquipments;
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return const VisibleInventoryNumberList();
                  }
                  if (state.searchText.isNotEmpty &&
                      state.visibleList.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "Инвентарный номер не найден",
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: List.generate(
                        inventoryNumbers.length,
                        (index) {
                          return BlocBuilder<InventoryBloc, InventoryState>(
                            builder: (context, state) {
                              return ChipTheme(
                                data: ChipTheme.of(context).copyWith(
                                  elevation: 0,
                                  pressElevation: 0,
                                  selectedColor: secondaryGreen,
                                  backgroundColor: greyCard,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                  ),
                                ),
                                child: ChoiceChip(
                                  avatar: state.selectedEquipment != null &&
                                          inventoryNumbers[index]
                                                  .inventoryNumber ==
                                              state.selectedEquipment!
                                                  .inventoryNumber
                                      ? const Icon(
                                          Icons.done_rounded,
                                          color: Colors.white,
                                        )
                                      : null,
                                  label: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      inventoryNumbers[index]
                                          .inventoryNumber
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            state.selectedEquipment != null &&
                                                    inventoryNumbers[index]
                                                            .inventoryNumber ==
                                                        state.selectedEquipment!
                                                            .inventoryNumber
                                                ? Colors.white
                                                : blackLabels,
                                      ),
                                    ),
                                  ),
                                  selected: state.selectedEquipment != null &&
                                      inventoryNumbers[index].inventoryNumber ==
                                          state.selectedEquipment!
                                              .inventoryNumber,
                                  onSelected: (selected) {
                                    setState(() {
                                      selected = !selected;
                                    });

                                    context.read<RepairBloc>().add(
                                          RepairEquipmentChanged(
                                            inventoryNumbers[index],
                                          ),
                                        );

                                    context.read<InventoryBloc>().add(
                                          InventoryEquipmentSelected(
                                            inventoryNumbers[index],
                                          ),
                                        );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}


/*
(selected) {
                                setState(() {
                                  selected = !selected;
                                });
                                context
                                    .read<ClassroomBloc>()
                                    .add(ClassroomSelected(classrooms[index]));
                                if (classrooms[index].number == "Все") {
                                  context.read<ClassroomEquipmentBloc>().add(
                                        const ClassroomEquipmentLoadUserEquipmentsList(),
                                      );
                                }
                                context.read<ClassroomEquipmentBloc>().add(
                                      ClassroomEquipmentSelectedClassroom(
                                        classrooms[index],
                                      ),
                                    );
                              },
*/
