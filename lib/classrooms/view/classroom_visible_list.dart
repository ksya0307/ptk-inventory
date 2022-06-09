import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/view/classroom_row.dart';
import 'package:ptk_inventory/config/colors.dart';

class VisibleClassroomList extends StatelessWidget {
  const VisibleClassroomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomBloc, ClassroomState>(
      builder: (context, state) {
        final classrooms = state.visibleList;
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
                    itemCount: classrooms.length,
                    itemBuilder: (context, index) {
                      final String patronymic =
                          classrooms[index].user.patronymic != null
                              ? classrooms[index].user.patronymic!
                              : "";
                      return InkWell(
                        onTap: () {
                          context.read<ClassroomBloc>().add(
                                ClassroomSelected(
                                  Classroom(
                                    number: classrooms[index].number,
                                    user: classrooms[index].user,
                                  ),
                                ),
                              );

                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (_) => BlocProvider.value(
                          //       value: context.read<ClassroomBloc>(),
                          //       child: EquipmentDetailsPage(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: ClassroomRow(
                          number: classrooms[index].number,
                          fullName:
                              "${classrooms[index].user.surname} ${classrooms[index].user.name} $patronymic",
                          last: index == classrooms.length - 1,
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
