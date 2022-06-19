import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/model/document.dart';
import 'package:ptk_inventory/documents/view/document_row.dart';
import 'package:ptk_inventory/documents/view/update_document/update_document_page.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';

class VisibleDocumentList extends StatefulWidget {
  const VisibleDocumentList({
    Key? key,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;

  @override
  State<VisibleDocumentList> createState() => _VisibleDocumentListState();
}

class _VisibleDocumentListState extends State<VisibleDocumentList> {
  int groupValue = -1;
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
                      return widget.radioButton == null
                          ? InkWell(
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
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                id: (index + 1).toString(),
                                document: documents[index].name,
                                last: index == documents.length - 1,
                              ),
                            )
                          : InkWell(
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
                                id: (index + 1).toString(),
                                document: documents[index].name,
                                last: index == documents.length - 1,
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                radio: Radio<int>(
                                  groupValue: groupValue,
                                  value: index,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                      BlocProvider.of<InventoryBloc>(context)
                                          .add(
                                        InventoryDocumentSelected(
                                          selectedDocument: documents[index],
                                        ),
                                      );
                                    });
                                  },
                                ),
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
