import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_page.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/model/inventory.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/steps/first_step.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/steps/second_step.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/steps/third_step.dart';
import 'package:ptk_inventory/inventory/view/custom_stepper.dart' as c_s;
import 'package:ptk_inventory/palette.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddInventoryForm extends StatefulWidget {
  @override
  State<AddInventoryForm> createState() => AddInventoryFormState();
}

class AddInventoryFormState extends State<AddInventoryForm> {
  @override
  void initState() {
    super.initState();
  }

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        print(state.formStatus);
        print(state.inventoryActionStatus);
        if (state.formStatus == FormzStatus.submissionSuccess &&
            state.inventoryActionStatus == InventoryActionStatus.added) {
          snackbarMessage(
            context,
            "Оборудование принято к учету",
          );
          Navigator.of(context).pop();
          context.read<InventoryBloc>().add(const InventoryLoadList());
        }
        if (state.formStatus == FormzStatus.submissionFailure &&
            state.inventoryActionStatus == InventoryActionStatus.notAdded) {
          snackbarMessageCommonError(
            context,
            "Оборудование не принято к учету",
          );
        }
        if (state.inventoryActionStatus == InventoryActionStatus.emptyFields) {
          snackbarMessageCommonError(
            context,
            "Заполните необходимые поля",
          );
        }
      },
      child: c_s.CustomStepper(
        physics: const ClampingScrollPhysics(),
        currentStep: currentStep,
        onStepTapped: (index) {
          setState(() => currentStep = index);
        },
        onStepContinue: () {
          if (currentStep != 2) {
            setState(() => currentStep++);
          }
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          }
        },
        controlsBuilder: (context, controls) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: controls.onStepCancel,
                      child: SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color:
                                  currentStep == 0 ? greySteps : secondaryGreen,
                            ),
                            Text(
                              "Назад",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: currentStep == 0
                                    ? greySteps
                                    : secondaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: currentStep != 2
                    ? const EdgeInsets.only(right: 2)
                    : const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed:
                          currentStep == 2 ? () {} : controls.onStepContinue,
                      child: SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            if (currentStep == 2)
                              BlocBuilder<InventoryBloc, InventoryState>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () => context
                                        .read<InventoryBloc>()
                                        .add(
                                          InventorySubmitted(
                                            BlocProvider.of<AuthenticationBloc>(
                                              context,
                                            ).state.user,
                                          ),
                                        ),
                                    child: const Text(
                                      "Принять",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: secondaryGreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: 'Rubik',
                                      ),
                                    ),
                                  );
                                },
                              )
                            else
                              const Text(
                                "Продолжить",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: secondaryGreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                ),
                              ),
                            if (currentStep != 2)
                              const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: secondaryGreen,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        type: c_s.StepperType.horizontal,
        elevation: 0,
        steps: <c_s.Step>[
          c_s.Step(
            state: currentStep <= 0
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 0,
            title: currentStep == 0
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Оборудование',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: redCustom,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: const FirstStepForm(),
          ),
          c_s.Step(
            state: currentStep <= 1
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 1,
            title: currentStep == 1
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Документы',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: redCustom,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: const SecondStepForm(),
          ),
          c_s.Step(
            state: currentStep <= 2
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 2,
            title: currentStep == 2
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Комментарий',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' - Необязательно',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: greyDark,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: const ThirdStepForm(),
          ),
        ],
      ),
    );
  }
}
