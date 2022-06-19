import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/view/show_equipment_details/equipement_details_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_row.dart';

class VisibleClassroomEquipmentList extends StatefulWidget {
  const VisibleClassroomEquipmentList({
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
  State<VisibleClassroomEquipmentList> createState() =>
      _VisibleClassroomEquipmentListState();
}

class _VisibleClassroomEquipmentListState
    extends State<VisibleClassroomEquipmentList> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final equipment = state.visibleList;
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
                                          numberInClassroom: equipment[index]
                                              .numberInClassroom,
                                          equipmentType:
                                              equipment[index].equipmentType,
                                        ),
                                      ),
                                    );

                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => BlocProvider.value(
                                      value: context
                                          .read<ClassroomEquipmentBloc>(),
                                      child: EquipmentDetailsPage(),
                                    ),
                                  ),
                                );
                              },
                              inventoryNumber:
                                  equipment[index].inventoryNumber.toString(),
                              numberInClassroom:
                                  equipment[index].numberInClassroom,
                              category:
                                  equipment[index].equipment.category.name,
                              last: index == equipment.length - 1,

                              // groupValue: groupValue,
                              // onChange: (equipments) {
                              //   setState(() {
                              //     print(equipment[index].id);
                              //     groupValue = equipments;
                              //   });
                              // },
                              // value: index,
                            
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
                                          numberInClassroom: equipment[index]
                                              .numberInClassroom,
                                          equipmentType:
                                              equipment[index].equipmentType,
                                        ),
                                      ),
                                    );

                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => BlocProvider.value(
                                      value: context
                                          .read<ClassroomEquipmentBloc>(),
                                      child: EquipmentDetailsPage(),
                                    ),
                                  ),
                                );
                              },
                              inventoryNumber:
                                  equipment[index].inventoryNumber.toString(),
                              numberInClassroom:
                                  equipment[index].numberInClassroom,
                              category:
                                  equipment[index].equipment.category.name,
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
