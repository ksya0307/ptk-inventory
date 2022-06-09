import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';

class AddClassroomForm extends StatelessWidget {
  const AddClassroomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PropertyLabel(property: 'Номер аудитории', bottomPadding: 8),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.3),
          child: BlocBuilder<ClassroomBloc, ClassroomState>(
            builder: (context, state) {
              return PropertyInput(
                hintText: '100',
                onChange: (number) {
                  context
                      .read<ClassroomBloc>()
                      .add(ClassroomNumberChanged(number));
                },
              );
            },
          ),
        )
      ],
    );
  }
}
