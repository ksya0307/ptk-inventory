import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/view/custom_stepper.dart' as c_s;
import 'package:ptk_inventory/palette.dart';
import 'package:toggle_switch/toggle_switch.dart';

class InventoryForm extends StatefulWidget {
  @override
  State<InventoryForm> createState() => InventoryFormState();
}

class InventoryFormState extends State<InventoryForm> {
  @override
  void initState() {
    super.initState();
  }

  int currentStep = 0;
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Нажмите для выбора даты';
    } else {
      return '${date?.day} - ${date?.month} - ${date?.year}';
    }
  }

  Widget propertyLabel(
    String property,
    double paddingLeft,
    double paddingBottom,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, bottom: paddingBottom),
      child: Text(
        property,
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget firstProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        propertyLabel("Выберите инвентарный номер", 16, 4, 18, FontWeight.w500),
        // _ChooseInventoryNumber(),
        inventoryNumberChips(),
        Align(alignment: Alignment.centerRight, child: showLabel()),
        propertyLabel("или найдите", 16, 0, 16, FontWeight.w400),
        searchAddContainer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        propertyLabel("Дата принятия к учету", 16, 8, 18, FontWeight.w500),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: chooseDate(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        propertyLabel("Закуплено для аудитории", 16, 4, 18, FontWeight.w500),
        classroomsChips(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        propertyLabel("Выдано", 16, 8, 18, FontWeight.w500),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: givenToggle(),
        )
      ],
    );
  }

  Widget secondProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        documentLabel(),
        searchFieldDocument(),
        listOfDocuments(),
        searchIfo(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        byRequestLabel(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: byRequestToggle(),
        )
      ],
    );
  }

  Widget thirdProperty() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
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
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  color: blackInput,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontFamily: 'Rubik'),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    top: 12,
                  ),
                  hintText: 'Оставьте комментарий',
                ),
                maxLength: 250,
                maxLines: 5,
                cursorColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget documentLabel() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        "Документ, контракт",
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  List documents = [
    '"Договор № 196/ЕП(Т)20-ВБ от 20.10.2020 УПД № 20201103-00001 от 03.11.2020"',
    '"Договор № 193/ЕП(Т)20-ВБ от 19.10.2020УПД № 20201116-00002 от 16.11.2020"',
    '"Договор № 192/ЕП(Т)20-ВБ от 18.10.2020 УПД № 20201123-00006 от 16.11.2020"',
    '"Договор № 200/ЕП(Т)20-ВБ от 21.10.2020 УПД № 20201133-00006 от 14.11.2020"'
  ];

  void searchDocs(String query) {
    final suggestions = documents.where((docs) {
      final docsTitle = docs.toString().toLowerCase();
      final input = query.toLowerCase();

      return docsTitle.contains(input);
    }).toList();
    setState(() => documents = suggestions);
  }

  Widget searchFieldDocument() {
    final TextEditingController editingController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
            controller: editingController,
            onChanged: (value) => searchDocs(value),
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 16,
              color: blackLabels,
            ),
            cursorColor: Theme.of(context).primaryColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
              hintStyle: TextStyle(
                fontFamily: 'Rubik',
                color: greyDark,
              ),
              hintText: 'Договор № 100...',
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
      ),
    );
  }

  Widget searchIfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
            onChanged: (value) => searchDocs(value),
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 16,
              color: blackLabels,
            ),
            cursorColor: Theme.of(context).primaryColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
              hintText: 'грант МинПрос...',
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
      ),
    );
  }

  Widget byRequestLabel() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        "Приобретено по заявке",
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget byRequestToggle() {
    return ToggleSwitch(
      totalSwitches: 2,
      cornerRadius: 7,
      labels: const ['Нет', 'Да'],
      onToggle: (index) {},
      borderWidth: 2,
      borderColor: const [secondaryGreen],
      activeBgColor: const [secondaryGreen],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: greyDark,
    );
  }

  Widget listOfDocuments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final docs = documents[index];
            return ListTile(
              title: Text(docs.toString()),
            );
          },
        ),
      ),
    );
  }

  Widget chooseInventoryNumber() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, bottom: 5),
      child: Text(
        'Выберите инвентарный номер',
        style: TextStyle(
          color: blackLabels,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  final List<String> _choiceList = [
    '101340003428',
    '101340034',
    '101340003428',
    '101340003428',
    '101340003428'
  ];

  Widget inventoryNumberChips() {
    const int selected = 0;
    bool _isSelected = false;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Wrap(
          spacing: 8,
          children: List.generate(_choiceList.length, (index) {
            return FilterChip(
              pressElevation: 0,
              checkmarkColor: Colors.white,
              // avatar: doneIcon,
              elevation: 0,
              selectedColor: secondaryGreen,
              backgroundColor: greyCard,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              label: Text(_choiceList[index]),
              labelStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: _isSelected ? blackLabels : blackLabels,
              ),
              selected: selected == index,
              onSelected: (bool value) {
                setState(() {
                  _isSelected = true;
                  // doneIcon = Icon(Icons.done_rounded, color: Colors.white);
                });
              },
            );
          }),
        ),
      ),
    );
  }

  Widget showLabel() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 16, 8),
      child: Text(
        'Просмотр',
        textAlign: TextAlign.end,
        style: TextStyle(
          color: primaryBlue,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget searchInventoryContainer() {
    return Theme(
      data: ThemeData(
        primarySwatch: Palette.customBlue,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: blueCustom),
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 12,
              ),
              const Icon(
                Icons.search_rounded,
                color: primaryBlue,
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 212,
                child: TextFormField(
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    hintText: '12456789012',
                    hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: greyDark,
                    ),
                    border: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greyCard,
                        width: 0,
                      ),
                      // borderRadius: BorderRadius.circular(7)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greyCard,
                        width: 0,
                      ),
                      // borderRadius: BorderRadius.circular(7)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blueInputFocuced,
                        width: 0,
                      ),
                      // borderRadius: BorderRadius.circular(7)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greyCard,
                        width: 0,
                      ),
                      // borderRadius: BorderRadius.circular(7)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addEquipmentContainer() {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(blueOverlay),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all(
          greyCard,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(12, 0, 0, 0),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () => Navigator.of(context).push(AddEquipmentPage.route()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.add_rounded,
            color: Color.fromRGBO(0, 47, 167, 1.0),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Добавить оборудование",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(68, 68, 68, 1.0),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget searchAddContainer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Container(
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        child: SizedBox(
          height: 100,
          width: 260,
          // child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: searchInventoryContainer()),
              SizedBox(
                height: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ),
              ),
              Expanded(child: addEquipmentContainer())
            ],
          ),
        ),
      ),
    );
  }

  Widget chooseDate() {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          const Color.fromRGBO(82, 124, 234, 0.1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all(
          greyCard,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(12, 0, 18, 0),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () async {
        final initDate = DateTime.now();
        final DateTime? newDate = await showDatePicker(
          cancelText: "Отмена",
          confirmText: "Выбрать",
          helpText: "Выбрать дату принятия к учету",
          context: context,
          initialDate: initDate,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
        );
        // if 'Cancel' => null
        if (newDate == null) return;
        //of Ok =>DateTime
        setState(() => date = newDate);
      },
      child: SizedBox(
        height: 50,
        width: 230,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: primaryBlue,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              getText(),
              style: const TextStyle(
                color: blackLabels,
                fontSize: 14,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
              ),
            ),
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
    bool _isSelected = false;
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
                labelStyle: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  // fontWeight: FontWeight.w400,
                  color: _isSelected ? blackInput : blackInput,
                ),
                selected: selected == index,
                onSelected: (bool value) {
                  setState(() {
                    _isSelected = true;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  bool isSwitched = false;

  Widget givenToggle() {
    return ToggleSwitch(
      totalSwitches: 2,
      cornerRadius: 7,
      labels: const ['Нет', 'Да'],
      borderWidth: 2,
      borderColor: const [secondaryGreen],
      activeBgColor: const [secondaryGreen],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: greyDark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.customGreen)
            .copyWith(secondary: Palette.customBlue),
      ),
      child: c_s.CustomStepper(
        physics: const ClampingScrollPhysics(),
        currentStep: currentStep,
        onStepTapped: (index) {
          setState(() => currentStep = index);
        },
        onStepContinue: () {
          if (currentStep != 2) {
            setState(() => currentStep++);
          }
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          }
        },
        controlsBuilder: (context, controls) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: controls.onStepCancel,
                      child: SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color:
                                  currentStep == 0 ? greySteps : secondaryGreen,
                            ),
                            Text(
                              "Назад",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: currentStep == 0
                                    ? greySteps
                                    : secondaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: currentStep != 2
                    ? const EdgeInsets.only(right: 2)
                    : const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed:
                          currentStep == 2 ? () {} : controls.onStepContinue,
                      child: SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            Text(
                              currentStep == 2 ? "Принять" : "Продолжить",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Rubik',
                              ),
                            ),
                            if (currentStep != 2)
                              const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: secondaryGreen,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        type: c_s.StepperType.horizontal,
        elevation: 0,
        steps: <c_s.Step>[
          c_s.Step(
            state: currentStep <= 0
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 0,
            title: currentStep == 0
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Оборудование',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: redCustom,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: firstProperty(),
          ),
          c_s.Step(
            state: currentStep <= 1
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 1,
            title: currentStep == 1
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Документы',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: redCustom,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: secondProperty(),
          ),
          c_s.Step(
            state: currentStep <= 2
                ? c_s.StepState.indexed
                : c_s.StepState.complete,
            isActive: currentStep >= 2,
            title: currentStep == 2
                ? RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Комментарий',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: blackLabels,
                          ),
                        ),
                        TextSpan(
                          text: ' - Необязательно',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: greyDark,
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(""),
            content: thirdProperty(),
          ),
        ],
      ),
    );
  }
}
