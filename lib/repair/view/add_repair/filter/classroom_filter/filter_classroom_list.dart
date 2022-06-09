import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';

class FilterClassroomList extends StatefulWidget {
  const FilterClassroomList({
    Key? key,
    this.bottomPadding = 0,
  }) : super(key: key);
  final double bottomPadding;
  @override
  State<FilterClassroomList> createState() => _ClassroomListState();
}

class _ClassroomListState extends State<FilterClassroomList> {
  @override
  Widget build(BuildContext context) {
    final classrooms =
        BlocProvider.of<ClassroomBloc>(context).state.globalClassrooms;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocListener<ClassroomBloc, ClassroomState>(
            listener: (context, state) {},
            child: BlocBuilder<ClassroomBloc, ClassroomState>(
              builder: (context, state) {
                //Color _color = secondaryGreen;
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    runSpacing: 8,
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

                              context
                                  .read<ClassroomBloc>()
                                  .add(ClassroomSelected(classrooms[index]));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
