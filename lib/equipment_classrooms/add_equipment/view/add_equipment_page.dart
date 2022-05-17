import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ptk_inventory/category/view/add_category_page.dart';
import 'package:ptk_inventory/config/theme/colors.dart';
import 'package:ptk_inventory/equipment_classrooms/equipment_specs/view/equipment_specs_page.dart';

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
                context: context,
                builder: (BuildContext context) {
                  return const FilterBottomSheet();
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
                  minHeight: view.minWidth,
                ),
                child: addEquipmentForm(context),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints view) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: view.minWidth,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back_rounded,
                          color: primaryBlue,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Center(
                            child: Text(
                              "Категория",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryBlue,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const CategorySearch(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [addCategory(context)],
                    ),
                    const ApplyFilter()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget addEquipmentSpecs(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(EquipmentSpecsPage.route()),
    child: const Padding(
      padding: EdgeInsets.only(top: 8, right: 16),
      child: Text(
        "Добавить",
        style: TextStyle(
          color: primaryBlue,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget addCategory(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(AddCategoryPage.route()),
    child: const SizedBox(
      height: 48,
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          "Добавить",
          style: TextStyle(
            color: primaryBlue,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

class ApplyFilter extends StatelessWidget {
  const ApplyFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryBlue),
          ),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
            child: Text(
              "Применить фильтр",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget addEquipmentForm(BuildContext context) {
  return Form(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          propertyLabel(
            'Инвентарный номер',
            ' *',
            redCustom,
            FontWeight.w500,
            18,
          ),
          const InventoryNumberInput(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Оборудование',
            ' — Необязательно',
            greyDark,
            FontWeight.w400,
            16,
          ),
          const SearchEquipmentSpecs(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [addEquipmentSpecs(context)],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Аудитория',
            ' — Необязательно',
            greyDark,
            FontWeight.w400,
            16,
          ),
          classroomsChips(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Внутренний номер',
            ' — Необязательно',
            greyDark,
            FontWeight.w400,
            16,
          ),
          const InternalEquipmentNumberInput(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          ),
          propertyLabel(
            'Принадлежность оборудования',
            ' *',
            redCustom,
            FontWeight.w500,
            18,
          ),
          const EquipmentBelongingRadioButtons(),
          const AddEquipmentButton(),
        ],
      ),
    ),
  );
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

Widget propertyLabel(
  String firstText,
  String secondText,
  Color secondTextColor,
  FontWeight fontWeightSecondText,
  double secondsTextSize,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: blackLabels,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: secondsTextSize,
              color: secondTextColor,
              fontWeight: fontWeightSecondText,
            ),
          )
        ],
      ),
    ),
  );
}

class InventoryNumberInput extends StatefulWidget {
  const InventoryNumberInput({Key? key}) : super(key: key);

  @override
  State<InventoryNumberInput> createState() => _InventoryNumberInputState();
}

class _InventoryNumberInputState extends State<InventoryNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          key: const Key('equipmentForm_inventoryNumberInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            hintText: '1212548453454',

            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
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
                color: blueCustom,
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
            // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
          ),
        ),
      ),
    );
  }
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

MaskTextInputFormatter internalNumberMask = MaskTextInputFormatter(
  mask: '###-##',
  filter: {"#": RegExp('[0-9]')},
);

class InternalEquipmentNumberInput extends StatefulWidget {
  const InternalEquipmentNumberInput({Key? key}) : super(key: key);

  @override
  State<InternalEquipmentNumberInput> createState() =>
      _InternalEquipmentNumberInputState();
}

class _InternalEquipmentNumberInputState
    extends State<InternalEquipmentNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [internalNumberMask],
          key: const Key('equipmentForm_internalNumberInput_textField'),
          cursorColor: Theme.of(context).primaryColor,
          minLines: 1,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: blackInput,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
            errorStyle: const TextStyle(
              color: redCustom,
              fontFamily: 'Rubik',
            ),
            hintText: '100-01',

            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
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
                color: blueCustom,
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
            // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
          ),
        ),
      ),
    );
  }
}

enum EquipmentBelonging { lab, prod, other }

class EquipmentBelongingRadioButtons extends StatefulWidget {
  const EquipmentBelongingRadioButtons({Key? key}) : super(key: key);

  @override
  State<EquipmentBelongingRadioButtons> createState() =>
      _EquipmentBelongingRadioButtonsState();
}

class _EquipmentBelongingRadioButtonsState
    extends State<EquipmentBelongingRadioButtons> {
  EquipmentBelonging? _belonging = EquipmentBelonging.lab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 16, 0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Учебно-лабораторное оборудование',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.lab,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Учебно-производственное оборудование',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.prod,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Другое',
              style: TextStyle(
                fontFamily: 'Rubik',
                color: blackInput,
                fontSize: 16,
              ),
            ),
            leading: Radio<EquipmentBelonging>(
              activeColor: secondaryGreen,
              value: EquipmentBelonging.other,
              groupValue: _belonging,
              onChanged: (EquipmentBelonging? value) {
                setState(() {
                  _belonging = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddEquipmentButton extends StatelessWidget {
  const AddEquipmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(
              primaryBlue,
            ),
          ),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 12 + 3, 0, 12 + 3),
            child: Text(
              "Добавить",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
