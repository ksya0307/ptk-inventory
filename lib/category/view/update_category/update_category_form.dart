import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/delete_button.dart';
import 'package:ptk_inventory/common/component/modal_bottom_sheet_delete.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';

class UpdateCategoryForm extends StatelessWidget {
  const UpdateCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PropertyLabel(
              property: 'Название',
              bottomPadding: 8,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                if (state.selectedCategory != null) {
                  return PropertyInput(
                    initialValue: state.selectedCategory!.name,
                    hintText: 'Смартфон',
                    errorText: 'Название категории не может быть пустым',
                    propertyInvalid: state.name.invalid,
                    onChange: (name) => context
                        .read<CategoryBloc>()
                        .add(CategoryNameChanged(name)),
                  );
                }
                return const Text("Категория не выбрана");
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: BlocListener<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state.categoryActionStatus ==
                      CategoryActionStatus.saved) {
                    snackbarMessage(context, "Категория сохранена");
                    context.read<CategoryBloc>().add(
                          CategorySaveToList(
                            category: state.selectedCategory!,
                          ),
                        );
                    context
                        .read<CategoryBloc>()
                        .add(const CategorySelected(null));
                  }
                  if (state.categoryActionStatus ==
                      CategoryActionStatus.savedOnGlobal) {
                    Navigator.of(context).pop();
                  }

                  if (state.categoryActionStatus ==
                      CategoryActionStatus.notSaved) {
                    snackbarMessageCommonError(
                      context,
                      "Категория уже существует",
                    );
                  }
                },
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  buildWhen: (previous, current) =>
                      previous.formStatus != current.formStatus,
                  builder: (context, state) {
                    return state.formStatus.isSubmissionInProgress
                        ? const InProgress(
                            inProgressText: 'Сохранение...',
                          )
                        : CommonButton(
                            formValidated: state.formStatus.isValidated,
                            buttonText: 'Сохранить',
                            onPress: () {
                              context
                                  .read<CategoryBloc>()
                                  .add(const CategorySaved());
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            BlocListener<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state.categoryActionStatus ==
                    CategoryActionStatus.deleted) {
                  snackbarMessage(context, "Категория удалена");
                }

                if (state.categoryActionStatus ==
                    CategoryActionStatus.deletedFromGlobal) {
                  Navigator.of(context).pop();
                }
                if (state.categoryActionStatus ==
                    CategoryActionStatus.notDeleted) {
                  snackbarMessageError(
                    context,
                    "Категория не может быть удалена",
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: DeleteButton(
                        bottomSheet: BlocProvider.value(
                          value: context.read<CategoryBloc>(),
                          child: ConfirmDeletingBottomSheet(
                            deleteProperty: 'категорию',
                            onPress: () {
                              context.read<CategoryBloc>().add(
                                    CategoryDeleted(
                                      state.selectedCategory!.id,
                                    ),
                                  );
                              Navigator.of(context).pop();
                              context.read<CategoryBloc>().add(
                                    CategoryDeleteFromList(
                                      category: state.selectedCategory!,
                                    ),
                                  );
                              context
                                  .read<CategoryBloc>()
                                  .add(const CategorySelected(null));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
