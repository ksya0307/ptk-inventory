import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/common/component/property_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_common_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/view/add_document/add_document_button.dart';
import 'package:ptk_inventory/documents/view/add_document/document_name_input.dart';

class AddDocumentForm extends StatelessWidget {
  const AddDocumentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentBloc, DocumentState>(
      listener: (context, state) {
        if (state.formStatus == FormzStatus.submissionSuccess) {
          snackbarMessage(context, "Новый документ добавлен");
          Navigator.of(context).pop();
        } else if (state.formStatus == FormzStatus.submissionFailure) {
          snackbarMessageCommonError(context, "Такой документ уже существует");
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            PropertyLabel(property: 'Название', bottomPadding: 8),
            DocumentNameInput(),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: AddDocumentButton(),
            )
          ],
        ),
      ),
    );
  }
}
