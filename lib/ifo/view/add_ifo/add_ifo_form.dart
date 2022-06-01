import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/button_in_progress.dart';
import 'package:ptk_inventory/common/component/property_input.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';

class AddIfoForm extends StatelessWidget {
  const AddIfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<IfoBloc, IfoState>(
      listener: (context, state) {
        if (state.ifoActionStatus == IfoActionStatus.added) {
          snackbarMessage(context, "Новый ИФО добавлена");
          Navigator.of(context).pop();
          //context.read<CategoryBloc>().add(const CategoryLoadList());
        }

        if (state.ifoActionStatus == IfoActionStatus.notAdded) {
          snackbarMessageCommonError(context, "Такой ИФО уже существует");
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const PropertyLabel(
              property: 'Название',
              bottomPadding: 8,
            ),
            BlocBuilder<IfoBloc, IfoState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return PropertyInput(
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
                          inProgressText: "Добавление...",
                        )
                      : CommonButton(
                          buttonText: "Добавить",
                          onPress: () {
                            context.read<IfoBloc>().add(const IfoSubmitted());
                          },
                          formValidated: state.formStatus.isValidated,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
