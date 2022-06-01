import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/delete_button.dart';
import 'package:ptk_inventory/common/component/modal_bottom_sheet_delete.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';

class UpdateIfoForm extends StatelessWidget {
  const UpdateIfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<IfoBloc, IfoState>(
      listener: (context, state) {
        //print("GLOBAl ${state.globalCategories}");
        if (state.ifoActionStatus == IfoActionStatus.saved) {
          snackbarMessage(context, "ИФО сохранен");
          context.read<IfoBloc>().add(IfoSaveToList(ifo: state.selectedIfo!));
          context.read<IfoBloc>().add(const IfoSelected(null));
        }
        if (state.ifoActionStatus == IfoActionStatus.savedOnGlobal) {
          Navigator.of(context).pop();
        }
        if (state.ifoActionStatus == IfoActionStatus.notSaved) {
          snackbarMessageError(context, "Такой ИФО уже существует");
        }
      },
      child: Column(
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
              BlocBuilder<IfoBloc, IfoState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return PropertyInput(
                    initialValue: state.selectedIfo!.name,
                    hintText: 'Грант А',
                    errorText: 'Название ИФО не может быть пустым',
                    propertyInvalid: state.name.invalid,
                    onChange: (ifo) =>
                        context.read<IfoBloc>().add(IfoNameChanged(ifo)),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: BlocBuilder<IfoBloc, IfoState>(
                  buildWhen: (previous, current) =>
                      previous.formStatus != current.formStatus,
                  builder: (context, state) {
                    return state.formStatus.isSubmissionInProgress
                        ? const InProgress(
                            inProgressText: "Сохранение...",
                          )
                        : CommonButton(
                            buttonText: 'Сохранить',
                            onPress: () {
                              context.read<IfoBloc>().add(const IfoSaved());
                            },
                            formValidated: state.formStatus.isValidated,
                          );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              BlocListener<IfoBloc, IfoState>(
                listener: (context, state) {
                  if (state.ifoActionStatus == IfoActionStatus.deleted) {
                    snackbarMessage(context, "ИФО удален");
                    // context
                    //     .read<CategoryBloc>()
                    //     .add(CategoryDeleteFromList(category: state.selectedCategory!));
                    // context.read<CategoryBloc>().add(const CategorySelected(null));
                  }
                  if (state.ifoActionStatus ==
                      IfoActionStatus.deletedFromGlobal) {
                    Navigator.of(context).pop();
                  }
                  if (state.ifoActionStatus == IfoActionStatus.notDeleted) {
                    snackbarMessageError(context, "ИФО не может быть удален");
                  }
                },
                child: BlocBuilder<IfoBloc, IfoState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: DeleteButton(
                          bottomSheet: BlocProvider.value(
                        value: context.read<IfoBloc>(),
                        child: ConfirmDeletingBottomSheet(
                          deleteProperty: 'ИФО',
                          onPress: () {
                            context
                                .read<IfoBloc>()
                                .add(IfoDeleted(state.selectedIfo!.id));
                            Navigator.of(context).pop();
                          },
                        ),
                      )),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
