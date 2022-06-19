import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/inventory_row.dart';

class VisibleInventoryList extends StatefulWidget {
  const VisibleInventoryList({
    Key? key,
    this.checkbox,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);
  final Widget? checkbox;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  @override
  State<VisibleInventoryList> createState() => _VisibleInventoryListState();
}

class _VisibleInventoryListState extends State<VisibleInventoryList> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        final inventory = state.visibleList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: greyCard,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: inventory.length,
                    itemBuilder: (context, index) {
                      return widget.checkbox == null
                          ? InventoryRow(
                              firstFlexRow: widget.firstFlexRow,
                              secondFlexRow: widget.secondFlexRow,
                              onTap: () {
                                // context.read<ClassroomEquipmentBloc>().add(
                                //       ClassroomEquipmentUserSelected(
                                //         ClassroomEquipment(
                                //           id: equipment[index].id,
                                //           inventoryNumber:
                                //               equipment[index].inventoryNumber,
                                //           classroom: equipment[index].classroom,
                                //           equipment: equipment[index].equipment,
                                //           numberInClassroom: equipment[index]
                                //               .numberInClassroom,
                                //           equipmentType:
                                //               equipment[index].equipmentType,
                                //         ),
                                //       ),
                                //     );

                                // Navigator.of(context).push(
                                //   MaterialPageRoute<void>(
                                //     builder: (_) => BlocProvider.value(
                                //       value: context
                                //           .read<ClassroomEquipmentBloc>(),
                                //       child: EquipmentDetailsPage(),
                                //     ),
                                //   ),
                                // );
                              },

                              last: index == inventory.length - 1,
                              equipment: inventory[index]
                                  .inventoryNumber
                                  .equipment
                                  .category
                                  .name,
                              getDate: DateFormat("dd-MM-yyyy")
                                  .format(inventory[index].getDate),
                              inventoryNumber: inventory[index]
                                  .inventoryNumber
                                  .inventoryNumber
                                  .toString(),
                              number: (index + 1).toString(),

                              // groupValue: groupValue,
                              // onChange: (equipments) {
                              //   setState(() {
                              //     print(equipment[index].id);
                              //     groupValue = equipments;
                              //   });
                              // },
                              // value: index,
                            )
                          : InventoryRow(
                              firstFlexRow: widget.firstFlexRow,
                              secondFlexRow: widget.secondFlexRow,
                              onTap: () {
                                // context.read<ClassroomEquipmentBloc>().add(
                                //       ClassroomEquipmentUserSelected(
                                //         ClassroomEquipment(
                                //           id: equipment[index].id,
                                //           inventoryNumber:
                                //               equipment[index].inventoryNumber,
                                //           classroom: equipment[index].classroom,
                                //           equipment: equipment[index].equipment,
                                //           numberInClassroom: equipment[index]
                                //               .numberInClassroom,
                                //           equipmentType:
                                //               equipment[index].equipmentType,
                                //         ),
                                //       ),
                                //     );

                                // Navigator.of(context).push(
                                //   MaterialPageRoute<void>(
                                //     builder: (_) => BlocProvider.value(
                                //       value: context
                                //           .read<ClassroomEquipmentBloc>(),
                                //       child: EquipmentDetailsPage(),
                                //     ),
                                //   ),
                                // );
                              },
                              last: index == inventory.length - 1,
                              equipment: inventory[index]
                                  .inventoryNumber
                                  .equipment
                                  .category
                                  .name,
                              getDate: DateFormat("dd-MM-yyyy")
                                  .format(inventory[index].getDate),
                              inventoryNumber: inventory[index]
                                  .inventoryNumber
                                  .inventoryNumber
                                  .toString(),
                              number: (index + 1).toString(),

                              // groupValue: groupValue,
                              // onChange: (equipments) {
                              //   setState(() {
                              //     print(equipment[index].id);
                              //     groupValue = equipments;
                              //   });
                              // },
                              // value: index,
                              widget: Text("Check"),
                              // Checkbox(
                              //   value: equipment[index].isChecked,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       equipment[index].isChecked = value!;

                              //       // print("value");
                              //       // print(value);
                              //       context.read<ClassroomEquipmentBloc>().add(
                              //             ClassroomEquipmentFilteredEquipment(
                              //               equipment[index],
                              //             ),
                              //           );
                              //     });
                              //   },
                              // ),
                            );
                    },
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
