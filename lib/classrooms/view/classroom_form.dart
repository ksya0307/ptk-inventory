import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/view/classroom_list.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';

class ClassroomForm extends StatelessWidget {
  const ClassroomForm({
    Key? key,
    this.bottomPadding = 0,
  }) : super(key: key);
  final double bottomPadding;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ClassroomBloc, ClassroomState>(
              builder: (context, state) {
                return SearchField(
                  hintText: '100',
                  keyboardType: TextInputType.text,
                  inputFormatters: const [],
                  onChange: (classroom) {
                    context
                        .read<ClassroomBloc>()
                        .add(ClassroomSearch(matchingWord: classroom));
                  },
                );
              },
            ),
            BlocBuilder<ClassroomBloc, ClassroomState>(
              builder: (context, state) {
                if (state.classroomLoadingStatus ==
                    ClassroomLoadingStatus.loadingInProgress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
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
                  return const ClassroomList();
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
        ),
      ),
    );
  }
}
