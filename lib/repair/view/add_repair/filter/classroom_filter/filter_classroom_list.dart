import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_visible_list.dart';

class FilterClassroomList extends StatefulWidget {
  const FilterClassroomList({
    Key? key,
    this.bottomPadding = 0,
    required this.bloc,
  }) : super(key: key);
  final double bottomPadding;
  final Type bloc;
  @override
  State<FilterClassroomList> createState() => _ClassroomListState();
}

class _ClassroomListState extends State<FilterClassroomList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomBloc, ClassroomState>(
      builder: (context, state) {
        final classrooms = state.globalClassrooms;
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ClassroomBloc, ClassroomState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return const VisibleFilterClassroomList();
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
                                    MediaQuery.of(context).size.height * 0.2,
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
                                          "Аудитория не найдена",
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
                      spacing: 8,
                      children: List.generate(
                        classrooms.length,
                        (index) {
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
                              avatar: state.selectedClassroom != null &&
                                      classrooms[index].number ==
                                          state.selectedClassroom!.number
                                  ? const Icon(
                                      Icons.done_rounded,
                                      color: Colors.white,
                                    )
                                  : null,
                              label: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  classrooms[index].number,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: state.selectedClassroom != null &&
                                            classrooms[index].number ==
                                                state.selectedClassroom!.number
                                        ? Colors.white
                                        : blackLabels,
                                  ),
                                ),
                              ),
                              selected: state.selectedClassroom != null &&
                                  classrooms[index].number ==
                                      state.selectedClassroom!.number,
                              onSelected: (selected) {
                                setState(() {
                                  selected = !selected;
                                });
                          
                                if (widget.bloc == ClassroomEquipmentBloc) {
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
                                }

                                context.read<ClassroomBloc>().add(
                                      ClassroomSelected(classrooms[index]),
                                    );

                                if (widget.bloc == InventoryBloc) {
                                  BlocProvider.of<InventoryBloc>(context).add(
                                    InventoryClassroomSelected(
                                      classrooms[index],
                                    ),
                                  );
                                }
                              },
                            ),
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
