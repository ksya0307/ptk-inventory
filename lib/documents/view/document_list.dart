import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/view/document_row.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documents =
        BlocProvider.of<DocumentBloc>(context).state.globalDocuments;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: greyCard,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.0),
                topRight: Radius.circular(7.0),
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '№',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Наименование',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: blackLabels,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  },
                  child: DocumentRow(
                    id: documents[index].id.toString(),
                    document: documents[index].name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
