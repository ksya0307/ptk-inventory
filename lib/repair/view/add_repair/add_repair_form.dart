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
import 'package:ptk_inventory/repair/view/add_repair/inventory_number_chips.dart';
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
              InventoryNumberChip(
                equipment: equipment,
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
                      property: '???????????????? ????????????????????????????',
                      bottomPadding: 8,
                    ),
                    BlocBuilder<RepairBloc, RepairState>(
                      buildWhen: (previous, current) =>
                          previous.problem != current.problem,
                      builder: (context, state) {
                        return PropertyInput(
                          propertyInvalid: state.problem.invalid,
                          errorText:
                              '???????????????? ???? ?????????? ???????? ????????????, ?????????????? ????????????????',
                          onChange: (problem) => context
                              .read<RepairBloc>()
                              .add(RepairProblemChanged(problem)),
                          maxLength: 700,
                          maxLines: 7,
                          hintText: '?????????????? ????????????',
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
                      property: '?????????? ???????????????? ?????? ??????????',
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
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          errorText: '?????????????? ???????????????????? ?????????? ????????????????',
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
                      property: '????????',
                      bottomPadding: 8,
                    ),
                    BlocBuilder<RepairBloc, RepairState>(
                      builder: (context, state) {
                        return ChooseDateButton(
                          date: date,
                          calendarText: "???????? ?????????????????????? ???????? ????????????-????????????????",
                          onPress: () async {
                            final initDate = DateTime.now();

                            final DateTime? newDate = await showDatePicker(
                              cancelText: "????????????",
                              confirmText: "??????????????",
                              helpText: "???????? ?????????????????????? ???????? ????????????-????????????????",
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
                      "${DateTime.now().day}.${DateFormat('MM').format(DateTime.now())}.${DateTime.now().year} ???? ??????????????????",
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
                          //   "?????? ????????????-???????????????? ???????????????????????? ?? ???????????? ????????????",
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
                                RepairActionStatus.notAdded &&
                            state.formStatus == FormzStatus.submissionFailure) {
                          snackbarMessageCommonError(
                            context,
                            "??????-???? ?????????? ???? ??????",
                          );
                        }
                      },
                      child: BlocBuilder<RepairBloc, RepairState>(
                        buildWhen: (previous, current) =>
                            previous.formStatus != current.formStatus,
                        builder: (context, state) {
                          return state.formStatus.isSubmissionInProgress
                              ? const InProgress(
                                  inProgressText: "????????????????????????...",
                                )
                              : CommonButton(
                                  fontSize: 18,
                                  buttonText: "????????????????????????",
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
