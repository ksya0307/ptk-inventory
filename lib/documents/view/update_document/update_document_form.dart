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
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';

class UpdateDocumentForm extends StatelessWidget {
  const UpdateDocumentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PropertyLabel(property: 'Название', bottomPadding: 8),
            BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, state) {
                return PropertyInput(
                  maxLength: 500,
                  maxLines: 7,
                  hintText: 'Договор №1',
                  errorText: 'Название документа не может быть пустым',
                  initialValue: state.selectedDocument!.name,
                  propertyInvalid: state.name.invalid,
                  onChange: (document) => context.read<DocumentBloc>().add(
                        DocumentNameChanged(document),
                      ),
                );
              },
            ),
            BlocListener<DocumentBloc, DocumentState>(
              listener: (context, state) {
                if (state.documentActionStatus == DocumentActionStatus.saved) {
                  snackbarMessage(context, "Документ сохранен");
                  context.read<DocumentBloc>().add(
                        DocumentSaveToList(document: state.selectedDocument!),
                      );
                  context
                      .read<DocumentBloc>()
                      .add(const DocumentSelected(null));
                }
                if (state.documentActionStatus ==
                    DocumentActionStatus.savedOnGlobal) {
                  Navigator.of(context).pop();
                }
                if (state.documentActionStatus ==
                    DocumentActionStatus.notSaved) {
                  snackbarMessageError(
                    context,
                    "Такой документ уже существует",
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: BlocBuilder<DocumentBloc, DocumentState>(
                  buildWhen: (previous, current) =>
                      previous.formStatus != current.formStatus,
                  builder: (context, state) {
                    return state.formStatus.isSubmissionInProgress
                        ? const InProgress(inProgressText: 'Сохранение...')
                        : CommonButton(
                            formValidated: state.formStatus.isValidated,
                            buttonText: 'Сохранить',
                            onPress: () {
                              context
                                  .read<DocumentBloc>()
                                  .add(const DocumentSaved());
                            },
                          );
                  },
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            BlocListener<DocumentBloc, DocumentState>(
              listener: (context, state) {
                if (state.documentActionStatus ==
                    DocumentActionStatus.deleted) {
                  snackbarMessage(context, "Документ удален");
                }
                if (state.documentActionStatus ==
                    DocumentActionStatus.deletedFromGlobal) {
                  Navigator.of(context).pop();
                }
                if (state.documentActionStatus ==
                    DocumentActionStatus.notDeleted) {
                  snackbarMessageError(
                    context,
                    "Документ не может быть удален",
                  );
                }
              },
              child: BlocBuilder<DocumentBloc, DocumentState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: DeleteButton(
                      bottomSheet: BlocProvider.value(
                        value: context.read<DocumentBloc>(),
                        child: ConfirmDeletingBottomSheet(
                          deleteProperty: 'документ',
                          onPress: () {
                            context.read<DocumentBloc>().add(
                                  DocumentDeleted(state.selectedDocument!.id),
                                );
                            Navigator.of(context).pop();
                            context.read<DocumentBloc>().add(
                                  DocumentDeleteFromList(
                                    document: state.selectedDocument!,
                                  ),
                                );
                            context
                                .read<DocumentBloc>()
                                .add(const DocumentSelected(null));
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
