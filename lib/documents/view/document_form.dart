import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/bloc/document_bloc.dart';
import 'package:ptk_inventory/documents/view/document_list.dart';
import 'package:ptk_inventory/documents/view/search_document.dart';

class DocumentForm extends StatelessWidget {
  const DocumentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchDocument(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state.documentLoadingStatus ==
                    DocumentLoadingStatus.loadingInProgress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Загрузка документов...",
                                  style: TextStyle(
                                    color: greyDark,
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state.documentLoadingStatus ==
                        DocumentLoadingStatus.loadingSuccess &&
                    state.globalDocuments.isNotEmpty) {
                  return const DocumentsList();
                }
                if (state.documentLoadingStatus ==
                        DocumentLoadingStatus.loadingSuccess &&
                    state.globalDocuments.isEmpty) {
                  return const Text("Список документов пуст");
                }
                return const Text("Что-то пошло не так");
              },
            ),
          )
        ],
      ),
    );
  }
}
