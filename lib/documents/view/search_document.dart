import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';

class SearchDocument extends StatelessWidget {
  const SearchDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous.visibleList != current.visibleList,
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
          child: Theme(
            data: ThemeData(
              textSelectionTheme:
                  const TextSelectionThemeData(selectionColor: blueCustom),
            ),
            child: TextField(
              onChanged: (query) {
                context
                    .read<DocumentBloc>()
                    .add(DocumentSearch(matchingWord: query));
              },
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                color: blackLabels,
              ),
              cursorColor: Theme.of(context).primaryColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                hintText: 'Договор №1',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: primaryBlue,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
