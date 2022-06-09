import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/classrooms/model/classroom.dart';
import 'package:ptk_inventory/classrooms/view/classroom_row.dart';
import 'package:ptk_inventory/classrooms/view/classroom_visible_list.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';

import 'package:ptk_inventory/config/colors.dart';

class ClassroomList extends StatelessWidget {
  const ClassroomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classrooms =
        BlocProvider.of<ClassroomBloc>(context).state.globalClassrooms;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 8),
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
                      'Сотрудник',
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
          BlocBuilder<ClassroomBloc, ClassroomState>(
            builder: (context, state) {
              if (state.visibleList.isNotEmpty) {
                return const VisibleClassroomList();
              }
              if (state.searchText.isNotEmpty && state.visibleList.isEmpty) {
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state.user.role == UserRole.admin) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
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
                                  "для добавления новой аудитории",
                                  style: TextStyle(
                                    color: blackLabels,
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Container(
                      decoration: const BoxDecoration(
                        color: greyCard,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7.0),
                          bottomRight: Radius.circular(7.0),
                        ),
                      ),
                      child: Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      ),
                    );
                  },
                );
              }
              return Container(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
