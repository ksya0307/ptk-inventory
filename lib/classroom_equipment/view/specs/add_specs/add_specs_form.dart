import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/common/category_dropmenu.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/property_input.dart';

import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/config/colors.dart';

class AddSpecsForm extends StatefulWidget {
  const AddSpecsForm({Key? key}) : super(key: key);

  @override
  State<AddSpecsForm> createState() => _AddSpecsFormState();
}

class _AddSpecsFormState extends State<AddSpecsForm> {
  String? category;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const PropertyLabel(
            property: 'Характеристики',
            bottomPadding: 8,
          ),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) => previous.specs != current.specs,
            builder: (context, state) {
              return PropertyInput(
                propertyInvalid: state.specs.invalid,
                errorText: 'Характеристики не могут быть пустыми',
                onChange: (specs) => context
                    .read<ClassroomEquipmentBloc>()
                    .add(ClassroomEquipmentSpecsChanged(specs)),
                maxLength: 700,
                maxLines: 7,
                hintText: 'Mikrotik D732',
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          const PropertyLabel(
            property: 'Категория',
            bottomPadding: 8,
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.categoryLoadingStatus ==
                  CategoryLoadingStatus.loadingInProgress) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                "Загрузка категорий...",
                                style: TextStyle(
                                  color: greyDark,
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state.categoryLoadingStatus ==
                      CategoryLoadingStatus.loadingSuccess &&
                  state.globalCategories.isNotEmpty) {
                return Column(
                  children: [
                    CategoryDropDown(
                      value: category == "" ? "" : category,
                      category: category,
                      onChanged: (String? value) {
                        setState(() {
                          category = value ?? "";
                        });

                        final Category selectedCategory = state.globalCategories
                            .where((select) => select.name == category)
                            .first;
                        print(selectedCategory);
                        context.read<ClassroomEquipmentBloc>().add(
                              ClassroomEquipmentSpecsCategorySelected(
                                selectedCategory,
                              ),
                            );
                      },
                      globalCategories: state.globalCategories,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocListener<ClassroomEquipmentBloc,
                        ClassroomEquipmentState>(
                      listener: (context, state) {
                        if (state.equipmentActionStatus ==
                                EquipmentActionStatus.added &&
                            state.classroomEquipmentLoadingStatus ==
                                ClassroomEquipmentLoadingStatus
                                    .loadingSuccess) {
                          snackbarMessage(
                            context,
                            "Новое оборудование добавлено",
                          );

                          Navigator.of(context).pop();
                          context
                              .read<ClassroomEquipmentBloc>()
                              .add(const ClassroomEquipmentLoadSpecs());
                        }
                        if (state.equipmentActionStatus ==
                                EquipmentActionStatus.notAdded &&
                            state.classroomEquipmentLoadingStatus ==
                                ClassroomEquipmentLoadingStatus.loadingFailed) {
                          snackbarMessageCommonError(
                            context,
                            "Такое оборудование уже существует",
                          );
                        }
                        if (state.equipmentActionStatus ==
                            EquipmentActionStatus.emptyFields) {
                          snackbarMessageCommonError(
                            context,
                            "Заоплните необходимые поля",
                          );
                        }
                      },
                      child: BlocBuilder<ClassroomEquipmentBloc,
                          ClassroomEquipmentState>(
                        buildWhen: (previous, current) =>
                            previous.formStatus != current.formStatus,
                        builder: (context, state) {
                          return state.formStatus.isSubmissionInProgress
                              ? const InProgress(
                                  inProgressText: 'Добавление...',
                                )
                              : CommonButton(
                                  fontSize: 18,
                                  formValidated: state.formStatus.isValidated,
                                  buttonText: 'Добавить',
                                  onPress: () {
                                    context.read<ClassroomEquipmentBloc>().add(
                                          const ClassroomEquipmentSpecsSubmitted(),
                                        );
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state.categoryLoadingStatus ==
                      CategoryLoadingStatus.loadingSuccess &&
                  state.globalCategories.isEmpty) {
                return const Text("Список категорий пуст");
              }
              return const Text("Что-то пошло не так");
            },
          )
          // BlocBuilder<IfoBloc, IfoState>(
          //   buildWhen: (previous, current) => previous.name != current.name,
          //   builder: (context, state) {
          //     return PropertyInput(
          //       hintText: 'Грант А',
          //       errorText: 'Название ИФО не может быть пустым',
          //       propertyInvalid: state.name.invalid,
          //       onChange: (ifo) =>
          //           context.read<IfoBloc>().add(IfoNameChanged(ifo)),
          //     );
          //   },
          // ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: BlocBuilder<IfoBloc, IfoState>(
          //     buildWhen: (previous, current) =>
          //         previous.formStatus != current.formStatus,
          //     builder: (context, state) {
          //       return state.formStatus.isSubmissionInProgress
          //           ? const InProgress(
          //               inProgressText: "Добавление...",
          //             )
          //           : CommonButton(
          //               fontSize: 18,
          //               buttonText: "Добавить",
          //               onPress: () {
          //                 context.read<IfoBloc>().add(const IfoSubmitted());
          //               },
          //               formValidated: state.formStatus.isValidated,
          //             );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
