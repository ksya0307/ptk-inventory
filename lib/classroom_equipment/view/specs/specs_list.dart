import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment/model/equipment.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_row.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_visible_list.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/update_specs/update_specs_page.dart';
import 'package:ptk_inventory/config/colors.dart';

class SpecsList extends StatefulWidget {
  const SpecsList({
    Key? key,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
    this.notFound,
  }) : super(key: key);
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  final bool? notFound;
  @override
  State<SpecsList> createState() => _SpecsListState();
}

class _SpecsListState extends State<SpecsList> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    final specs =
        BlocProvider.of<ClassroomEquipmentBloc>(context).state.globalSpecs;
    return SingleChildScrollView(
      child: Padding(
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
                  if (widget.radioButton != null)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 16,
                          bottom: 16,
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
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 16, bottom: 16),
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
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Характеристики',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
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
              child:
                  BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
                builder: (context, state) {
                  if (state.specsVisibleList.isNotEmpty) {
                    return SpecsVisibleList(
                      radioButton: widget.radioButton,
                      firstFlex: widget.firstFlex,
                      firstFlexRow: widget.firstFlexRow,
                      secondFlex: widget.secondFlex,
                      secondFlexRow: widget.secondFlexRow,
                    );
                  }
                  if (state.searchText.isNotEmpty &&
                      state.specsVisibleList.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
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
                                      if (widget.notFound == false)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            // direction: Axis.vertical,
                                            children: [
                                              const Text(
                                                "Используйте",
                                                style: TextStyle(
                                                  color: blackLabels,
                                                  fontFamily: 'Rubik',
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryBlue,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "для добавления нового оборудования",
                                                style: TextStyle(
                                                  color: blackLabels,
                                                  fontFamily: 'Rubik',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        const SizedBox(height: 0),
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
