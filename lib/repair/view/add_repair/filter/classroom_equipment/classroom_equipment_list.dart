import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/view/show_equipment_details/equipement_details_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_row.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/visible_list.dart';

class ClassroomEquipmentList extends StatefulWidget {
  final Widget? checkbox;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;

  const ClassroomEquipmentList({
    Key? key,
    this.checkbox,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<ClassroomEquipmentList> createState() => _ClassroomEquipmentListState();
}

class _ClassroomEquipmentListState extends State<ClassroomEquipmentList> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final equipment =
        BlocProvider.of<ClassroomEquipmentBloc>(context).state.globalEquipments;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
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
                      padding:
                          const EdgeInsets.only(left: 12, top: 16, bottom: 16),
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
                    padding:
                        const EdgeInsets.only(left: 18, top: 16, bottom: 16),
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
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Инвентарный номер',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: blackLabels,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
            child: BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
              builder: (context, state) {
              
                if (state.visibleList.isNotEmpty) {
                  return VisibleClassroomEquipmentList(
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
                  itemCount: equipment.length,
                  itemBuilder: (context, index) {
                    return widget.checkbox == null
                        ? ClassroomEquipmentRow(
                            firstFlexRow: widget.firstFlexRow,
                            secondFlexRow: widget.secondFlexRow,
                            onTap: () {
                              context.read<ClassroomEquipmentBloc>().add(
                                    ClassroomEquipmentUserSelected(
                                      ClassroomEquipment(
                                        id: equipment[index].id,
                                        inventoryNumber:
                                            equipment[index].inventoryNumber,
                                        classroom: equipment[index].classroom,
                                        equipment: equipment[index].equipment,
                                        numberInClassroom:
                                            equipment[index].numberInClassroom,
                                        equipmentType:
                                            equipment[index].equipmentType,
                                      ),
                                    ),
                                  );

                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BlocProvider.value(
                                    value:
                                        context.read<ClassroomEquipmentBloc>(),
                                    child: EquipmentDetailsPage(),
                                  ),
                                ),
                              );
                            },
                            inventoryNumber:
                                equipment[index].inventoryNumber.toString(),
                            numberInClassroom:
                                equipment[index].numberInClassroom,
                            category: equipment[index].equipment.category.name,
                            last: index == equipment.length - 1,

                            // groupValue: groupValue,
                            // onChange: (equipments) {
                            //   setState(() {
                            //     print(equipment[index].id);
                            //     groupValue = equipments;
                            //   });
                            // },
                            // value: index,
                            widget: null,
                          )
                        : ClassroomEquipmentRow(
                            firstFlexRow: widget.firstFlexRow,
                            secondFlexRow: widget.secondFlexRow,
                            onTap: () {
                              context.read<ClassroomEquipmentBloc>().add(
                                    ClassroomEquipmentUserSelected(
                                      ClassroomEquipment(
                                        id: equipment[index].id,
                                        inventoryNumber:
                                            equipment[index].inventoryNumber,
                                        classroom: equipment[index].classroom,
                                        equipment: equipment[index].equipment,
                                        numberInClassroom:
                                            equipment[index].numberInClassroom,
                                        equipmentType:
                                            equipment[index].equipmentType,
                                      ),
                                    ),
                                  );

                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BlocProvider.value(
                                    value:
                                        context.read<ClassroomEquipmentBloc>(),
                                    child: EquipmentDetailsPage(),
                                  ),
                                ),
                              );
                            },
                            inventoryNumber:
                                equipment[index].inventoryNumber.toString(),
                            numberInClassroom:
                                equipment[index].numberInClassroom,
                            category: equipment[index].equipment.category.name,
                            last: index == equipment.length - 1,

                            // groupValue: groupValue,
                            // onChange: (equipments) {
                            //   setState(() {
                            //     print(equipment[index].id);
                            //     groupValue = equipments;
                            //   });
                            // },
                            // value: index,
                            widget: Checkbox(
                              value: equipment[index].isChecked,
                              onChanged: (value) {
                                setState(() {
                                  equipment[index].isChecked = value!;

                                  // print("value");
                                  // print(value);
                                  context.read<ClassroomEquipmentBloc>().add(
                                        ClassroomEquipmentFilteredEquipment(
                                          equipment[index],
                                        ),
                                      );
                                });
                              },
                            ),
                          );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
