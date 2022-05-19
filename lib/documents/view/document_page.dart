import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/documents/view/add_document_page.dart';
import 'package:ptk_inventory/ifo/view/add_ifo_page.dart';

class DocumentsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DocumentsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Назад",
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Документы",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DocumentForm(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DocumentForm extends StatelessWidget {
  const DocumentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SearchDocument(),
      ]),
    );
  }
}

class DocumentsList extends StatelessWidget {
  const DocumentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: categories.length,
            //   itemBuilder: (context, index) {
            //     return GestureDetector(
            //       onTap: () => Navigator.of(context).push(
            //         MaterialPageRoute<void>(
            //           builder: (_) => BlocProvider.value(
            //             value: context.read<CategoryBloc>(),
            //             child: UpdateCategoryPage(),
            //           ),
            //         ),
            //       ),
            //       child: CategoryRow(
            //         id: categories[index].id.toString(),
            //         category: categories[index].name,
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}

class SearchDocument extends StatelessWidget {
  const SearchDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            color: blackLabels,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
            hintText: 'Смартфон',
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}
