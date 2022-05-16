import 'package:flutter/material.dart';
import 'package:ptk_inventory/category/view/add_category_page.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class CategoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CategoryPage());
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
          "Категории",
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
                    children: [
                      categoryForm(context),
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

Widget categoryForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchCategory(context),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: CategoryTable(),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(AddCategoryPage.route()),
          child: const SizedBox(
            height: 48,
            child: Text(
              "Добавить",
              style: TextStyle(
                color: primaryBlue,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget searchCategory(BuildContext context) {
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
          suffixIcon: Icon(
            Icons.clear_rounded,
            color: primaryBlue,
          ),
        ),
      ),
    ),
  );
}

class CategoryTable extends StatefulWidget {
  const CategoryTable({Key? key}) : super(key: key);

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 2,
      dataTextStyle: const TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        color: blackLabels,
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            '№',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Rubik',
              fontSize: 16,
              color: blackLabels,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Название',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Rubik',
              fontSize: 16,
              color: blackLabels,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            '',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Rubik',
              fontSize: 16,
              color: blackLabels,
            ),
          ),
        )
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                '1',
              ),
            ),
            DataCell(
              Text(
                'Компьютер',
              ),
            ),
            DataCell(
              Icon(
                Icons.open_in_new_rounded,
                color: primaryBlue,
              ),
            )
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                '2',
              ),
            ),
            DataCell(
              Text(
                'Смартфон',
              ),
            ),
            DataCell(
              Icon(
                Icons.open_in_new_rounded,
                color: primaryBlue,
              ),
            )
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                '3',
              ),
            ),
            DataCell(
              Text(
                'Телевизор',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  color: blackLabels,
                ),
              ),
            ),
            DataCell(
              Icon(
                Icons.open_in_new_rounded,
                color: primaryBlue,
              ),
            )
          ],
        ),
      ],
    );
  }
}
