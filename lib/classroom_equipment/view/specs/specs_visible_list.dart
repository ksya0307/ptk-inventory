import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_row.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/update_specs/update_specs_page.dart';
import 'package:ptk_inventory/config/colors.dart';

class SpecsVisibleList extends StatefulWidget {
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  const SpecsVisibleList({
    Key? key,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<SpecsVisibleList> createState() => _SpecsVisibleListState();
}

class _SpecsVisibleListState extends State<SpecsVisibleList> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final specs = state.specsVisibleList;
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
                    itemCount: specs.length,
                    itemBuilder: (context, index) {
                      return widget.radioButton == null
                          ? InkWell(
                              onTap: () {
                                context.read<ClassroomEquipmentBloc>().add(
                                      ClassroomEquipmentSpecsSelected(
                                        Equipment(
                                          id: specs[index].id,
                                          description: specs[index].description,
                                          category: specs[index].category,
                                        ),
                                      ),
                                    );
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: context
                                              .read<ClassroomEquipmentBloc>(),
                                        ),
                                        BlocProvider.value(
                                          value: context.read<CategoryBloc>(),
                                        ),
                                      ],
                                      child: UpdateSpecsPage(),
                                    ),
                                  ),
                                );
                              },
                              child: SpecsRow(
                                radio: null,
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                id: (index + 1).toString(),
                                specs: specs[index].description.length >= 25 &&
                                        specs[index].description.length >= 50
                                    ? "${specs[index].description.substring(0, 40)}..."
                                    : specs[index].description,
                                last: index == specs.length - 1,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                context.read<ClassroomEquipmentBloc>().add(
                                      ClassroomEquipmentSpecsSelected(
                                        Equipment(
                                          id: specs[index].id,
                                          description: specs[index].description,
                                          category: specs[index].category,
                                        ),
                                      ),
                                    );
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: context
                                              .read<ClassroomEquipmentBloc>(),
                                        ),
                                        BlocProvider.value(
                                          value: context.read<CategoryBloc>(),
                                        ),
                                      ],
                                      child: UpdateSpecsPage(),
                                    ),
                                  ),
                                );
                              },
                              child: SpecsRow(
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                id: (index + 1).toString(),
                                specs: specs[index].description.length >= 25 &&
                                        specs[index].description.length >= 50
                                    ? "${specs[index].description.substring(0, 40)}..."
                                    : specs[index].description,
                                last: index == specs.length - 1,
                                radio: Radio<int>(
                                  groupValue: groupValue,
                                  value: index,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                      context
                                          .read<ClassroomEquipmentBloc>()
                                          .add(
                                            ClassroomEquipmentSpecsSelected(
                                              specs[index],
                                            ),
                                          );
                                    });
                                  },
                                ),
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
