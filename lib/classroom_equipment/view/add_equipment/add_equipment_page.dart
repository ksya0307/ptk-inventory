import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_form.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_form.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/common/component/search_field.dart';

import 'package:ptk_inventory/config/colors.dart';

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
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<ClassroomEquipmentBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<CategoryBloc>(),
                      ),
                    ],
                    child: EquipmentFilterSheet(
                      onTap: () => Navigator.of(context).pop(),
                      initialChildSize: 0.7,
                      maxChildSize: 0.9,
                      title: 'Все категории',
                      minChildSize: 0.3,
                      widget: Column(
                        children: [
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              return SearchField(
                                hintText: 'Смартфон',
                                keyboardType: TextInputType.text,
                                inputFormatters: const [],
                                onChange: (category) => {
                                  context.read<CategoryBloc>().add(
                                        CategorySearch(
                                          matchingWord: category,
                                        ),
                                      )
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CategoryForm(
                            firstFlexRow: 2,
                            secondFlexRow: 5,
                            firstFlex: 2,
                            secondFlex: 5,
                            widget: const SizedBox(),
                            categoryNotFoundWidget: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                // direction: Axis.vertical,
                                children: [
                                  const Text(
                                    "Используйте",
                                    style: TextStyle(
                                      color: blackLabels,
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryBlue,
                                      ),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "для добавления новой категории",
                                    style: TextStyle(
                                      color: blackLabels,
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            topPaddingSearchCategory: 0,
                          ),
                        ],
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
