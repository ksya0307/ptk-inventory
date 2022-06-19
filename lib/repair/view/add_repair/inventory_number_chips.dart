import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';

class InventoryNumberChip extends StatefulWidget {
  const InventoryNumberChip({
    Key? key,
    required this.equipment,
  }) : super(key: key);

  @override
  State<InventoryNumberChip> createState() => _InventoryNumberChipState();
  final List<ClassroomEquipment> equipment;
}

class _InventoryNumberChipState extends State<InventoryNumberChip> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
      
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 48,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 8,
              children: List.generate(
              widget.  equipment.length,
                (index) {
                  // print("allly");
                  // print(equipment[index].isChecked);
                  if (widget.equipment[index].isChecked == false) {
                    // print("not checked");
                    return const SizedBox(
                      height: 0,
                    );
                  }

                  return BlocBuilder<RepairBloc, RepairState>(
                    builder: (context, state) {
                      return ChipTheme(
                        data: ChipTheme.of(context).copyWith(
                          checkmarkColor: Colors.white,
                          elevation: 0,
                          disabledColor: Colors.white,
                          pressElevation: 0,
                          backgroundColor: secondaryGreen,
                          selectedColor: secondaryGreen,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                        ),
                        child: ChoiceChip(
                          avatar: state.selectedEquipment != null &&
                                widget.  equipment[index].inventoryNumber ==
                                      state.selectedEquipment!.inventoryNumber
                              ? const Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                )
                              : null,
                          selected: state.selectedEquipment != null &&
                            widget.  equipment[index].inventoryNumber ==
                                  state.selectedEquipment!.inventoryNumber,
                          label: Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                            widget.  equipment[index].inventoryNumber.toString(),
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              // print(
                              //   "on select ${equipment[index].classroom}",
                              // );
                              selected = !selected;
                              context.read<RepairBloc>().add(
                                    RepairEquipmentChanged(
                                      widget .equipment[index],
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
            ),
          ),
        );
      },
    );
  }
}
