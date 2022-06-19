import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_list.dart';

class FilterClassroomForm extends StatelessWidget {
  const FilterClassroomForm({
    Key? key,
    this.bottomPadding = 0,
    required this.bloc,
  }) : super(key: key);
  final double bottomPadding;
  final Type bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ClassroomBloc, ClassroomState>(
          builder: (context, state) {
            if (state.classroomLoadingStatus ==
                ClassroomLoadingStatus.loadingInProgress) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              "Загрузка аудиторий...",
                              style: TextStyle(
                                color: greyDark,
                                fontFamily: 'Rubik',
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state.classroomLoadingStatus ==
                    ClassroomLoadingStatus.loadingSuccess &&
                state.globalClassrooms.isNotEmpty) {
              return FilterClassroomList(
                bloc: bloc,
                bottomPadding: bottomPadding,
              );
            }
            if (state.classroomLoadingStatus ==
                    ClassroomLoadingStatus.loadingSuccess &&
                state.globalClassrooms.isEmpty) {
              return const Text("Список аудиторий пуст");
            }

            return const Text("Что-то пошло не так");
          },
        ),
      ],
    );
  }
}
