import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/choose_inventory_number_label.dart';

class AddRepairForm extends StatelessWidget {
  const AddRepairForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      buildWhen: (previous, current) =>
          previous.filteredEquipment != current.filteredEquipment,
      builder: (context, state) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChooseInventoryNumberLabel(),
              if (state.filteredEquipment != null)
                ChipTheme(
                  data: ChipTheme.of(context).copyWith(
                    checkmarkColor: Colors.white,
                    elevation: 0,
                    disabledColor: Colors.white,
                    pressElevation: 0,
                    selectedColor: secondaryGreen,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ),
                  child: ChoiceChip(
                    avatar: const Icon(
                      Icons.done_rounded,
                      color: Colors.white,
                    ),
                    selected: true,
                    label: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        state.filteredEquipment!.inventoryNumber.toString(),
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onSelected: (s) {},
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
            ],
          ),
        );
      },
    );
  }
}
