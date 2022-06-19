import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/choose_date.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/view/add_repair/choose_inventory_number_label.dart';
import 'package:ptk_inventory/repair/view/load_document/load_document_page.dart';

class AddRepairForm extends StatefulWidget {
  const AddRepairForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddRepairForm> createState() => _AddRepairFormState();
}

class _AddRepairFormState extends State<AddRepairForm> {
  DateTime? date;
  MaskTextInputFormatter phoneNumber = MaskTextInputFormatter(
    mask: '(###) ###-##-##',
    filter: {"#": RegExp('[0-9]')},
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final equipment = state.filteredEquipment;
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChooseInventoryNumberLabel(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: 48,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 8,
                    children: List.generate(
                      equipment.length,
                      (index) {
                        // print("allly");
                        // print(equipment[index].isChecked);
                        if (equipment[index].isChecked == false) {
                          // print("not checked");
                          return const SizedBox(
                            height: 0,
                          );
                        }

                        return BlocBuilder<RepairBloc, RepairState>(
                          builder: (context, state) {
                            return ChipTheme(
                              data: ChipTheme.of(context).copyWith(
                                checkmarkColor: Colors.white,
                                elevation: 0,
                                disabledColor: Colors.white,
                                pressElevation: 0,
                                backgroundColor: secondaryGreen,
                                selectedColor: secondaryGreen,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                              ),
                              child: ChoiceChip(
                                avatar: state.selectedEquipment != null &&
                                        equipment[index].inventoryNumber ==
                                            state.selectedEquipment!
                                                .inventoryNumber
                                    ? const Icon(
                                        Icons.done_rounded,
                                        color: Colors.white,
                                      )
                                    : null,
                                selected: state.selectedEquipment != null &&
                                    equipment[index].inventoryNumber ==
                                        state
                                            .selectedEquipment!.inventoryNumber,
                                label: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, bottom: 4),
                                  child: Text(
                                    equipment[index].inventoryNumber.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onSelected: (selected) {
                                  setState(() {
                                    // print(
                                    //   "on select ${equipment[index].classroom}",
                                    // );
                                    selected = !selected;
                                    context.read<RepairBloc>().add(
                                          RepairEquipmentChanged(
                                            equipment[index],
                                          ),
                                        );
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (equipment.isEmpty || equipment.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: greyDivider,
                      thickness: .75,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const PropertyLabel(
                      property: 'Описание неисправностей',
                      bottomPadding: 8,
                    ),
                    BlocBuilder<RepairBloc, RepairState>(
                      buildWhen: (previous, current) =>
                          previous.problem != current.problem,
                      builder: (context, state) {
                        return PropertyInput(
                          propertyInvalid: state.problem.invalid,
                          errorText:
                              'Описание не может быть пустым, опишите проблему',
                          onChange: (problem) => context
                              .read<RepairBloc>()
                              .add(RepairProblemChanged(problem)),
                          maxLength: 700,
                          maxLines: 7,
                          hintText: 'Начните писать',
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: greyDivider,
                      thickness: .75,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const PropertyLabel(
                      property: 'Номер телефона для связи',
                      bottomPadding: 8,
                    ),
                    BlocBuilder<RepairBloc, RepairState>(
                      buildWhen: (previous, current) =>
                          previous.phone != current.phone,
                      builder: (context, state) {
                        return PropertyInput(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Container(
                              height: 32,
                              width: 32,
                              transformAlignment: Alignment.centerLeft,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "+7",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Rubik', fontSize: 18,),
                              ),
                            ),
                          ),
                          errorText: 'Введите корректный номер телефона',
                          propertyInvalid: state.phone.invalid,
                          onChange: (phone) => context
                              .read<RepairBloc>()
                              .add(RepairPhoneChanged(phone)),
                          hintText: '(900) 123-45-67',
                          inputFormatters: [phoneNumber],
                          keyboardType: TextInputType.number,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: greyDivider,
                      thickness: .75,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const PropertyLabel(
                      property: 'Дата',
                      bottomPadding: 8,
                    ),
                    BlocBuilder<RepairBloc, RepairState>(
                      builder: (context, state) {
                        return ChooseDateButton(
                          date: date,
                          calendarText: "Дата составления акта приема-передачи",
                          onPress: () async {
                            final initDate = DateTime.now();

                            final DateTime? newDate = await showDatePicker(
                              cancelText: "Отмена",
                              confirmText: "Выбрать",
                              helpText: "Дата составления акта приема-передачи",
                              context: context,
                              initialDate: initDate,
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );

                            // if 'Cancel' => null
                            if (newDate == null) return;
                            //of Ok =>DateTime
                            setState(() {
                              date = newDate;

                              final newNewDate = DateTime(
                                date!.year,
                                date!.month,
                                date!.day,
                                DateTime.now().hour,
                                DateTime.now().minute,
                                DateTime.now().second,
                                DateTime.now().millisecond,
                                DateTime.now().microsecond,
                              );

                              context
                                  .read<RepairBloc>()
                                  .add(RepairDateTimeChanged(newNewDate));
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${DateTime.now().day}.${DateFormat('MM').format(DateTime.now())}.${DateTime.now().year} по умолчанию",
                      style: const TextStyle(
                        color: greyDark,
                        fontFamily: 'Rubik',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 24,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: BlocListener<RepairBloc, RepairState>(
                      listener: (context, state) {
                        if (state.repairActionStatus ==
                                RepairActionStatus.added &&
                            state.formStatus == FormzStatus.submissionSuccess) {
                          // snackbarMessage(
                          //   context,
                          //   "Акт приема-передачи оборудования в ремонт создан",
                          // );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<RepairBloc>()
                                  ..add(const RepairShowDocument()),
                                child: const LoadDocumentPage(),
                              ),
                            ),
                          );
                        }
                        if (state.repairActionStatus ==
                            RepairActionStatus.notAdded) {
                          snackbarMessageCommonError(
                            context,
                            "Что-то пошло не так",
                          );
                        }
                      },
                      child: BlocBuilder<RepairBloc, RepairState>(
                        buildWhen: (previous, current) =>
                            previous.formStatus != current.formStatus,
                        builder: (context, state) {
                          return state.formStatus.isSubmissionInProgress
                              ? const InProgress(
                                  inProgressText: "Формирование...",
                                )
                              : CommonButton(
                                  fontSize: 18,
                                  buttonText: "Сформировать",
                                  onPress: () {
                                    context
                                        .read<RepairBloc>()
                                        .add(const RepairSubmitted());
                                  },
                                  formValidated: state.formStatus.isValidated,
                                );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
