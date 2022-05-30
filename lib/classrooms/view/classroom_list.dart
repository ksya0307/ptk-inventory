import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/view/classroom_row.dart';

import 'package:ptk_inventory/config/colors.dart';

class ClassroomList extends StatelessWidget {
  const ClassroomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classrooms =
        BlocProvider.of<ClassroomBloc>(context).state.globalClassrooms;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Wrap(
            children: [
              BlocBuilder<ClassroomBloc, ClassroomState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    //return const VisibleClassroomEquipmentList();
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
                                    MediaQuery.of(context).size.height * 0.3,
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
                                          "Аудитории не найдены",
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
                    itemCount: classrooms.length,
                    itemBuilder: (context, index) {
                      final String pastronymic =
                          classrooms[index].user.patronymic != null
                              ? "${classrooms[index].user.patronymic![0]}."
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
                          user: classrooms[index].user.patronymic ?? '',
                        ),
                      );
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
