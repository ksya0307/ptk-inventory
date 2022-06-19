import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/equipment_belongings_radio_buttons.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/property_label.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/add_specs/add_specs_page.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_form.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/right_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_form.dart';

MaskTextInputFormatter internalNumberMaskWithoutLetter = MaskTextInputFormatter(
  mask: '###-##',
  filter: {"#": RegExp('[0-9]')},
);

class AddEquipmentForm extends StatelessWidget {
  const AddEquipmentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          propertyLabel(
            'Инвентарный номер',
            ' *',
            redCustom,
            FontWeight.w500,
            18,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
              buildWhen: (previous, current) =>
                  previous.inventoryNumber != current.inventoryNumber,
              builder: (context, state) {
                return PropertyInput(
                  errorText: "Не может быть пустым",
                  hintText: '101340003313',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  propertyInvalid: state.inventoryNumber.invalid,
                  onChange: (inventoryNumber) =>
                      context.read<ClassroomEquipmentBloc>().add(
                            ClassroomEquipmentInventoryNumberChanged(
                              inventoryNumber,
                            ),
                          ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Оборудование',
            ' *',
            redCustom,
            FontWeight.w400,
            16,
          ),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            builder: (context, state) {
              return SpecsForm(
                buildWhen: (previous, current) =>
                    previous.globalSpecs != current.globalSpecs,
                notFound: true,
                firstFlex: 2,
                secondFlex: 5,
                secondFlexRow: 5,
                firstFlexRow: 2,
                widget: const SizedBox(),
              );
            },
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<ClassroomEquipmentBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<CategoryBloc>(),
                    ),
                  ],
                  child: AddSpecsPage(),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                RightLabel(
                  text: "Добавить",
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Аудитория',
            ' — Необязательно',
            greyDark,
            FontWeight.w400,
            16,
          ),
          const SizedBox(
            height: 8,
          ),
          const FilterClassroomForm(
            bloc: ClassroomEquipmentBloc,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Внутренний номер',
            ' — Необязательно',
            greyDark,
            FontWeight.w400,
            16,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
              builder: (context, state) {
                return PropertyInput(
                  hintText: '100-01',
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    internalNumberMaskWithoutLetter,
                  ],
                  onChange: (internalNumber) =>
                      context.read<ClassroomEquipmentBloc>().add(
                            ClassroomEquipmentInternalNumberChanged(
                              internalNumber,
                            ),
                          ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Принадлежность оборудования',
            ' *',
            redCustom,
            FontWeight.w500,
            18,
          ),
          const EquipmentBelongingRadioButtons(),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child:
                BlocListener<ClassroomEquipmentBloc, ClassroomEquipmentState>(
              listener: (context, state) {
                if (state.equipmentActionStatus ==
                        EquipmentActionStatus.added &&
                    state.formStatus == FormzStatus.submissionSuccess) {
                  snackbarMessage(context, "Новое оборудование добавлено");

                  Navigator.of(context).pop();
                  context.read<ClassroomEquipmentBloc>().add(
                        ClassroomEquipmentSelectedClassroom(
                          state.selectedClassroom,
                        ),
                      );
                }
                if (state.equipmentActionStatus ==
                        EquipmentActionStatus.notAdded &&
                    state.formStatus == FormzStatus.submissionFailure) {
                  snackbarMessageCommonError(
                    context,
                    "Оборудование с таким инвентарным номером уже существует",
                  );
                }
              },
              child:
                  BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
                buildWhen: (previous, current) =>
                    previous.formStatus != current.formStatus,
                builder: (context, state) {
                  return state.formStatus.isSubmissionInProgress
                      ? const InProgress(
                          inProgressText: "Добавление...",
                        )
                      : CommonButton(
                          fontSize: 18,
                          buttonText: "Добавить",
                          onPress: () => context
                              .read<ClassroomEquipmentBloc>()
                              .add(const ClassroomEquipmentCreated()),
                          formValidated: state.formStatus.isValidated,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
