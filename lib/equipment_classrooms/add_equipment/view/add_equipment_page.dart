import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/equipment_classrooms/add_equipment/view/add_category_text_button.dart';
import 'package:ptk_inventory/equipment_classrooms/add_equipment/view/add_equipment_form.dart';
import 'package:ptk_inventory/equipment_classrooms/add_equipment/view/apply_filter.dart';

class AddEquipmentPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => AddEquipmentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          tooltip: "Назад",
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: primaryBlue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: primaryBlue,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                builder: (_) {
                  return DraggableScrollableSheet(
                    expand: false,
                    builder: (context, controller) => ListView.builder(
                      controller: controller,
                      itemCount: 1,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: primaryBlue,
                                      ),
                                    ),
                                    Expanded(
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: const [
                                          Spacer(),
                                          Text(
                                            "Категория",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: primaryBlue,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const CategorySearch(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [AddCategory()],
                            ),
                            const ApplyFilter()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
        title: const Text(
          "Добавить оборудование",
          style: TextStyle(
            color: primaryBlue,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 18,
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
                child: const AddEquipmentForm(),
              ),
            );
          },
        ),
      ),
    );
  }
}

final List<String> _choiceListClassrooms = [
  '120',
  '119а',
  '123',
  '124',
  '127',
  '415',
  '403',
  '419'
];

Widget classroomsChips() {
  const int selected = 0;
  // var doneIcon = null;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Wrap(
        spacing: 8,
        children: List.generate(
          _choiceListClassrooms.length,
          (index) {
            return FilterChip(
              pressElevation: 0,
              checkmarkColor: Colors.white,
              // avatar: doneIcon,
              elevation: 0,
              selectedColor: secondaryGreen,
              backgroundColor: greyCard,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              label: Text(
                _choiceListClassrooms[index],
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              labelStyle: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                // fontWeight: FontWeight.w400,
              ),
              selected: selected == index, onSelected: (bool value) {},
            );
          },
        ),
      ),
    ),
  );
}

class SearchEquipmentSpecs extends StatefulWidget {
  const SearchEquipmentSpecs({Key? key}) : super(key: key);

  @override
  State<SearchEquipmentSpecs> createState() => _SearchEquipmentSpecsState();
}

class _SearchEquipmentSpecsState extends State<SearchEquipmentSpecs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Container(
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          enabled: false,
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
            hintText: 'Microtik',
            contentPadding: EdgeInsets.fromLTRB(12, 12 + 3, 12, 12 + 3),
            hintStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: greyDark,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CategorySearch extends StatefulWidget {
  const CategorySearch({Key? key}) : super(key: key);

  @override
  State<CategorySearch> createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
            hintText: 'Смартфон',
            contentPadding: EdgeInsets.fromLTRB(12, 12 + 3, 12, 12 + 3),
            hintStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: greyDark,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
