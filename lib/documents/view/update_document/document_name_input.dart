import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';

class DocumentNameInput extends StatelessWidget {
  const DocumentNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous.selectedDocument != current.selectedDocument,
      builder: (context, state) {
        if (state.selectedDocument != null) {
          return TextFormField(
            onChanged: (name) {
              context.read<DocumentBloc>().add(DocumentNameChanged(name));
            },
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 7,
            maxLength: 500,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: blackInput,
            ),
            initialValue: state.selectedDocument!.name,
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
              errorText: state.name.invalid
                  ? 'Имя документа не может быть пустым'
                  : null,
              errorStyle: const TextStyle(
                color: redCustom,
                fontFamily: 'Rubik',
              ),
              hintText: 'Договор №1',
              contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
              hintStyle: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: greyDark,
              ),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: redCustom,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: redCustom, width: 1.5),
                borderRadius: BorderRadius.circular(7.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: blueInputFocuced,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: greyDark,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          );
        }
        return const Text("Документ не выбран");
      },
    );
  }
}
