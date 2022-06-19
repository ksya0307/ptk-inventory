import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/inventory_row.dart';
import 'package:ptk_inventory/inventory/view/visible_list.dart';

class InventoryList extends StatefulWidget {
  final Widget? checkbox;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;

  const InventoryList({
    Key? key,
    this.checkbox,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final inventory =
        BlocProvider.of<InventoryBloc>(context).state.globalInventory;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Row(
            children: [
              if (widget.checkbox != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 18,
                      bottom: 18,
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
              Flexible(
                flex: widget.firstFlex,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 24, bottom: 24),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '№',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: blackLabels,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: widget.secondFlex,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Оборудование',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Дата принятия к учету',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          color: greyDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.0),
              bottomRight: Radius.circular(7.0),
            ),
          ),
          child: BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
              if (state.visibleList.isNotEmpty) {
                return VisibleInventoryList(
                  checkbox: widget.checkbox,
                  firstFlex: widget.firstFlex,
                  firstFlexRow: widget.firstFlexRow,
                  secondFlex: widget.secondFlex,
                  secondFlexRow: widget.secondFlexRow,
                );
              }
              if (state.searchText.isNotEmpty && state.visibleList.isEmpty) {
                return Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
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
                                      "Оборудование не найдено",
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

              return ListView.builder(
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
              );
            },
          ),
        )
      ],
    );
  }
}
