import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/common/component/apply_filter_label.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/show_all_label.dart';

import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/classroom_form.dart';

class ChooseClassroom extends StatelessWidget {
  const ChooseClassroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              print("1 call?");
              return BlocProvider<ClassroomBloc>.value(
                value: BlocProvider.of<ClassroomBloc>(
                  context,
                )..add(
                    ClassroomLoadUserList(
                      BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user
                          .id,
                    ),
                  ),
                child: BlocBuilder<ClassroomBloc, ClassroomState>(
                  builder: (context, state) {
                    print("2 call?");
                    return EquipmentFilterSheet(
                      title: 'Все аудитории',
                      widget: Column(
                        children: [
                          InkWell(
                            onTap: () {
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
                    );
                  },
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
