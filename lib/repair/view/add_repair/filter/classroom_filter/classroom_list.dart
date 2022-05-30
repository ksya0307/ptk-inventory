import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/classroom_row.dart';

class ClassroomList extends StatelessWidget {
  const ClassroomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classrooms =
        BlocProvider.of<ClassroomBloc>(context).state.globalClassrooms;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ClassroomBloc, ClassroomState>(
            builder: (context, state) {
              if (state.visibleList.isNotEmpty) {
                //return const VisibleClassroomEquipmentList();
              }
              if (state.searchText.isNotEmpty && state.visibleList.isEmpty) {
                return Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
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

              return Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(
                    classrooms.length,
                    (index) {
                      return ClassroomRow(
                        label: classrooms[index].number,
                        onSelect: (bool selected) {
                          print("Press ${classrooms[index]}");
                          context
                              .read<ClassroomBloc>()
                              .add(ClassroomSelected(classrooms[index]));
                        },
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
  }
}
