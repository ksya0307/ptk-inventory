import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/classroom_form.dart';

import 'package:ptk_inventory/repair/view/add_repair/filter/common/apply_filter_label.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/common/search_field.dart';
import 'package:ptk_inventory/repair/view/common/property_label.dart';
import 'package:ptk_inventory/repair/view/common/show_all_label.dart';

class ChooseClassroom extends StatelessWidget {
  const ChooseClassroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: const [
              PropertyLabel(
                property: 'Аудитория',
                bottomPadding: 0,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return BlocProvider<ClassroomBloc>.value(
                value: BlocProvider.of<ClassroomBloc>(
                  context,
                )..add(
                    ClassroomLoadUserList(
                        BlocProvider.of<AuthenticationBloc>(context)
                            .state
                            .user
                            .id),
                  ),
                child: makeDismissible(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.7,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    builder: (context, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                        child: ListView(
                          controller: controller,
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 24),
                              child: Flex(
                                direction: Axis.vertical,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 24,
                                        ),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Icon(
                                                Icons.arrow_back_rounded,
                                                color: primaryBlue,
                                              ),
                                            ),
                                            Expanded(
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children: const [
                                                  Spacer(),
                                                  Text(
                                                    "Все аудитории",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: primaryBlue,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      String selectedClassroom =
                                          BlocProvider.of<ClassroomBloc>(
                                                      context)
                                                  .state
                                                  .selectedClassroom
                                                  ?.number ??
                                              "";
                                      print("SELECTED ${selectedClassroom} !");
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        ApplyFilterLabel(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const ClassroomForm()
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: const [
                ShowAllLabel(
                  property: 'Показать все',
                  bottomPadding: 0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
