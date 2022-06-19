import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/view/classroom_row.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';

class VisibleInventoryNumberList extends StatefulWidget {
  const VisibleInventoryNumberList({Key? key}) : super(key: key);

  @override
  State<VisibleInventoryNumberList> createState() =>
      _VisibleInventoryNumberListState();
}

class _VisibleInventoryNumberListState
    extends State<VisibleInventoryNumberList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final inventoryNumbers = state.visibleList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Align(
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
                                      color: state.selectedEquipment != null &&
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
                                        state
                                            .selectedEquipment!.inventoryNumber,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
