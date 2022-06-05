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
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/classroom_form.dart';

class EquipmentClassroomForm extends StatelessWidget {
  const EquipmentClassroomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final teacherClassrooms = context.read<ClassroomBloc>()
          ..add(
            ClassroomLoadUserList(
              BlocProvider.of<AuthenticationBloc>(context).state.user.id,
            ),
          );
        final allClassrooms = context.read<ClassroomBloc>()
          ..add(
            const ClassroomLoadList(),
          );
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PropertyLabel(
                property: 'Аудитория',
                bottomPadding: 8,
              ),
              BlocProvider<ClassroomBloc>.value(
                value: state.user.role == UserRole.teacher
                    ? teacherClassrooms
                    : allClassrooms,
                child: const ClassroomForm(bottomPadding: 16),
              ),
              const ShowAllFilter(
                action: 'Показать все',
                containerColor: greyCard,
                property: 'Категория',
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
            ],
          ),
        );
      },
    );
  }
}
