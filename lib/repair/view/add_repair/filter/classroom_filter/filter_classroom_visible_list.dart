import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';

class VisibleFilterClassroomList extends StatefulWidget {
  const VisibleFilterClassroomList({Key? key}) : super(key: key);

  @override
  State<VisibleFilterClassroomList> createState() =>
      _VisibleFilterClassroomListState();
}

class _VisibleFilterClassroomListState
    extends State<VisibleFilterClassroomList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomBloc, ClassroomState>(
      buildWhen: (previous, current) =>
          previous.visibleList != current.visibleList,
      builder: (context, state) {
        final classrooms = state.visibleList;
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

                      context
                          .read<ClassroomBloc>()
                          .add(ClassroomSelected(classrooms[index]));

                      if (context.read<AuthenticationBloc>().state.user.role ==
                          UserRole.teacher) {
                        if (classrooms[index].number == "??????") {
                          context.read<ClassroomEquipmentBloc>().add(
                                const ClassroomEquipmentLoadUserEquipmentsList(),
                              );
                        }
                      }
                      context.read<ClassroomEquipmentBloc>().add(
                            ClassroomEquipmentSelectedClassroom(
                              classrooms[index],
                            ),
                          );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
