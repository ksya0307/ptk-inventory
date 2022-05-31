import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/view/document_row.dart';
import 'package:ptk_inventory/documents/view/update_document/update_document_page.dart';

class VisibleDocumentList extends StatelessWidget {
  const VisibleDocumentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        final documents = state.visibleList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: greyCard,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<DocumentBloc>().add(
                                DocumentSelected(
                                  Document(
                                    id: documents[index].id,
                                    name: documents[index].name,
                                  ),
                                ),
                              );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: context.read<DocumentBloc>(),
                                child: UpdateDocumentPage(),
                              ),
                            ),
                          );
                        },
                        child: DocumentRow(
                          id: documents[index].id.toString(),
                          document: documents[index].name,
                          last: index == documents.length - 1,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
