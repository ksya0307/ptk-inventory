import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/component/show_all_filter.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_equipment/classroom_equipment_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_form.dart';

class EquipmentClassroomForm extends StatelessWidget {
  const EquipmentClassroomForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PropertyLabel(
                property: 'Аудитория',
                bottomPadding: 4,
              ),
              SearchField(
                hintText: '102',
                keyboardType: TextInputType.text,
                inputFormatters: const [],
                onChange: (classroom) {
                  context
                      .read<ClassroomBloc>()
                      .add(ClassroomSearch(matchingWord: classroom));
                },
              ),
              const SizedBox(
                height: 8,
              ),
              if (state.user.role == UserRole.teacher)
                BlocProvider<ClassroomBloc>.value(
                  value: context.read<ClassroomBloc>()
                    ..add(
                      ClassroomLoadUserList(
                        BlocProvider.of<AuthenticationBloc>(context)
                            .state
                            .user
                            .id,
                      ),
                    ),
                  child: const FilterClassroomForm(
                    bottomPadding: 4,
                    bloc: ClassroomEquipmentBloc,
                  ),
                )
              else
                BlocProvider<ClassroomBloc>.value(
                  value: context.read<ClassroomBloc>()
                    ..add(
                      const ClassroomLoadList(),
                    ),
                  child: const FilterClassroomForm(
                    bottomPadding: 16,
                    bloc: ClassroomEquipmentBloc,
                  ),
                ),
              const ShowAllFilter(
                action: 'Показать все',
                containerColor: greyCard,
                property: 'Категория',
                firstFlexRow: 2,
                secondFlexRow: 5,
                firstFlex: 2,
                secondFlex: 5,
              ),
              const SizedBox(
                height: 8,
              ),
              SearchField(
                hintText: '101340003313',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChange: (inventoryNumber) => {
                  context.read<ClassroomEquipmentBloc>().add(
                        ClassroomEquipmentSearch(
                          inventoryNumber,
                        ),
                      ),
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const ClassroomEquipmentForm(
                firstFlexRow: 3,
                secondFlexRow: 7,
                firstFlex: 3,
                secondFlex: 7,
              )
            ],
          ),
        );
      },
    );
  }
}
