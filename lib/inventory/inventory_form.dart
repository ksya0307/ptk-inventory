import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ptk_inventory/inventory/custom_stepper.dart' as c_s;
import 'package:ptk_inventory/ui/palette.dart';

class InventoryForm extends StatefulWidget {
  @override
  State<InventoryForm> createState() => InventoryFormState();
}

class InventoryFormState extends State<InventoryForm> {
  int currentStep = 0;
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Нажмите для выбора даты';
    } else {
      return '${date?.day} - ${date?.month} - ${date?.year}';
    }
  }

  Widget _FirstProperty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ChooseInventoryNumber(),
        _InventoryNumberChips(),
        Align(alignment: Alignment.centerRight, child: _ShowLabel()),
        _SearchLabel(),
        _SearchAddContainer(),
        Padding(
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              thickness: .75,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
        _BoldLabel("Дата принятия к учету"),
        Padding(
          child: _ChooseDate(),
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        ),
        Padding(
            child: Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              thickness: .75,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
        _BoldLabel("Закуплено для аудитории"),
        _ClassroomsChips()
      ],
    );
  }

  Widget _ChooseInventoryNumber() {
    return Padding(
        padding: EdgeInsets.only(left: 16, bottom: 5),
        child: Text(
          'Выберите инвентарный номер',
          style: TextStyle(
              color: Color.fromRGBO(37, 37, 37, 1.0),
              fontFamily: 'PT Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ));
  }

  Widget _BoldLabel(String label) {
    return Padding(
        padding: EdgeInsets.only(left: 16, bottom: 12),
        child: Text(
          label,
          style: TextStyle(
              color: Color.fromRGBO(37, 37, 37, 1.0),
              fontFamily: 'PT Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ));
  }

  List<Widget> _InventoryNumbersChips() {
    bool _isSelected = false;
    List<Widget> chips = [];
    for (int i = 0; i < _choiceList.length; i++) {
      Widget item = Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: FilterChip(
              pressElevation: 0,
              checkmarkColor: Colors.white,
              elevation: 0,
              selectedColor: Color.fromRGBO(72, 206, 102, 1.0),
              backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              label: Text(_choiceList[i]),
              selected: _isSelected,
              labelStyle: TextStyle(
                fontFamily: 'PT Sans Caption',
                fontSize: 14,
                // color: _isSelected
                //     ? Color.fromRGBO(37, 37, 37, 1.0)
                //     : Colors.white),
              ),
              onSelected: (bool value) {
                setState(() {
                  _isSelected = value;
                });
              }));
      chips.add(item);
    }
    return chips;
  }

  List<String> _choiceList = [
    '101340003428',
    '101340034',
    '101340003428',
    '101340003428',
    '101340003428'
  ];

  Widget _InventoryNumberChips() {
    int selected = 0;
    // var doneIcon = null;
    bool _isSelected = false;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Wrap(
              spacing: 8,
              children: List.generate(_choiceList.length, (index) {
                return FilterChip(
                  pressElevation: 0,
                  checkmarkColor: Colors.white,
                  // avatar: doneIcon,
                  elevation: 0,
                  selectedColor: Color.fromRGBO(72, 206, 102, 1.0),
                  backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  label: Text(_choiceList[index]),
                  labelStyle: TextStyle(
                      fontFamily: 'PT Sans Caption',
                      fontSize: 14,
                      color: _isSelected
                          ? Color.fromRGBO(37, 37, 37, 1.0)
                          : Color.fromRGBO(37, 37, 37, 1.0)),
                  selected: selected == index,
                  onSelected: (bool value) {
                    setState(() {
                      _isSelected = true;
                      // doneIcon = Icon(Icons.done_rounded, color: Colors.white);
                    });
                  },
                );
              }),
            )));
  }

  Widget _ShowLabel() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 4, 16, 8),
        child: Text(
          'Просмотр',
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Color.fromRGBO(0, 47, 167, 1.0),
              fontFamily: 'PT Sans',
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ));
  }

  Widget _SearchLabel() {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        'или найдите',
        style: TextStyle(
            color: Color.fromRGBO(37, 37, 37, 1.0),
            fontSize: 16,
            fontFamily: 'PT Sans'),
      ),
    );
  }

  Widget _SearchInventoryContainer() {
    return Theme(
      data: ThemeData(primarySwatch: Palette.customBlue),
      child: Padding(
        padding: EdgeInsets.only(left: 0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(240, 240, 240, 1.0),
              borderRadius: BorderRadius.all(Radius.circular(7.0))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(
                Icons.search_rounded,
                color: Color.fromRGBO(0, 47, 167, 1.0),
              ),
              SizedBox(
                width: 12,
              ),
              SizedBox(
                  width: 212,
                  child: TextFormField(
                      autofocus: false,
                      maxLength: 20,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        hintText: '123456789012',
                        hintStyle: const TextStyle(
                            fontFamily: 'PT Sans Caption',
                            fontSize: 16,
                            color: Color.fromRGBO(150, 150, 150, 1.0)),
                        border: const OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(240, 240, 240, 1.0),
                              width: 0),
                          // borderRadius: BorderRadius.circular(7)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(240, 240, 240, 1.0),
                            width: 0,
                          ),
                          // borderRadius: BorderRadius.circular(7)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(240, 240, 240, 1.0),
                              width: 0),
                          // borderRadius: BorderRadius.circular(7)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(240, 240, 240, 1.0),
                              width: 0),
                          // borderRadius: BorderRadius.circular(7)
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _AddEquipmentContainer() {
    return ElevatedButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Color.fromRGBO(82, 124, 234, 0.1)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0))),
          alignment: Alignment.centerLeft,
          backgroundColor:
              MaterialStateProperty.all(Color.fromRGBO(240, 240, 240, 1.0)),
          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(12, 0, 0, 0)),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                fontFamily: 'PT Sans Caption',
              ),
            )
          ],
        ));
  }

  Widget _SearchAddContainer() {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            child: SizedBox(
                height: 100,
                width: 260,
                // child: Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _SearchInventoryContainer()),
                      SizedBox(
                          height: 1,
                          child: Container(
                              decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                          ))),
                      Expanded(child: _AddEquipmentContainer())
                    ]))));
  }

  Widget _ChooseDate() {
    return ElevatedButton(
      child: SizedBox(
        height: 50,
        width: 230,
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Color.fromRGBO(0, 47, 167, 1.0),
              ),
              SizedBox(
                width: 12,
              ),
              Text(getText(),
                  style: TextStyle(
                    color: Color.fromRGBO(68, 68, 68, 1.0),
                    fontSize: 14,
                    fontFamily: 'PT Sans Caption',
                  )),
            ]),
      ),
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all(Color.fromRGBO(82, 124, 234, 0.1)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0))),
        alignment: Alignment.centerLeft,
        backgroundColor:
            MaterialStateProperty.all(Color.fromRGBO(240, 240, 240, 1.0)),
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(12, 0, 18, 0)),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () async {
        final initDate = DateTime.now();
        DateTime? newDate = await showDatePicker(
            cancelText: "Отмена",
            confirmText: "Выбрать",
            helpText: "Выбрать дату принятия к учету",
            context: context,
            initialDate: initDate,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5));
        // if 'Cancel' => null
        if (newDate == null) return;
        //of Ok =>DateTime
        setState(() => date = newDate);
      },
      // icon: Icon(
      //   Icons.calendar_month_rounded,
      //   color: Color.fromRGBO(0, 47, 167, 1.0),
      // ),
      // label: Text(
      //   getText(),
      //   style: TextStyle(
      //     color: Color.fromRGBO(68, 68, 68, 1.0),
      //     fontSize: 14,
      //     fontFamily: 'PT Sans Caption',
      //   ),
      // )
    );
  }

  List<String> _choiceListClassrooms = [
    '120',
    '119а',
    '123',
    '124',
    '127',
    '415',
    '403',
    '419'
  ];

  Widget _ClassroomsChips() {
    int selected = 0;
    // var doneIcon = null;
    bool _isSelected = false;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Wrap(
              spacing: 8,
              children: List.generate(_choiceListClassrooms.length, (index) {
                return FilterChip(
                  pressElevation: 0,
                  checkmarkColor: Colors.white,
                  // avatar: doneIcon,
                  elevation: 0,
                  selectedColor: Color.fromRGBO(72, 206, 102, 1.0),
                  backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  label: Text(_choiceListClassrooms[index]),
                  labelStyle: TextStyle(
                      fontFamily: 'PT Sans Caption',
                      fontSize: 14,
                      color: _isSelected
                          ? Color.fromRGBO(37, 37, 37, 1.0)
                          : Color.fromRGBO(37, 37, 37, 1.0)),
                  selected: selected == index,
                  onSelected: (bool value) {
                    setState(() {
                      _isSelected = true;
                      // doneIcon = Icon(Icons.done_rounded, color: Colors.white);
                    });
                  },
                );
              }),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Palette.customGreen)
                  .copyWith(secondary: Palette.customBlue)),
      child: c_s.CustomStepper(
        currentStep: currentStep,
        onStepTapped: (index) {
          setState(() => currentStep = index);
        },
        onStepContinue: () {
          if (currentStep != 1) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: currentStep == 0
                          ? Color.fromRGBO(117, 117, 117, 1.0)
                          : Palette.customGreen,
                    ),
                    TextButton(
                        onPressed: controls.onStepCancel,
                        child: Text(
                          "Назад",
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: currentStep == 0
                                      ? Color.fromRGBO(117, 117, 117, 1.0)
                                      : Palette.customGreen)),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 16),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: controls.onStepContinue,
                        child: Text(
                          "Продолжить",
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                        )),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Palette.customGreen,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        margin: EdgeInsets.all(0),
        type: c_s.StepperType.horizontal,
        elevation: 0,
        steps: <c_s.Step>[
          c_s.Step(
              isActive: currentStep >= 0,
              title: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Оборудование',
                    style: TextStyle(
                        fontFamily: 'PT Sans Caption',
                        fontSize: 14,
                        color: Color.fromRGBO(37, 37, 37, 1.0))),
                TextSpan(
                    text: ' *',
                    style: TextStyle(
                        fontFamily: 'PT Sans Caption',
                        fontSize: 14,
                        color: Color.fromRGBO(227, 50, 69, 1.0)))
              ])),
              content: _FirstProperty()),
          c_s.Step(
              isActive: currentStep >= 1,
              title: Text('Дополнительно',
                  style: TextStyle(
                      fontFamily: 'PT Sans Caption',
                      fontSize: 14,
                      color: Color.fromRGBO(37, 37, 37, 1.0))),
              content: Text('df'))
          // c_s.Step(
          //     title: Text('Дополнительно',
          //         style: TextStyle(
          //             fontFamily: 'PT Sans Caption',
          //             fontSize: 14,
          //             color: Color.fromRGBO(37, 37, 37, 1.0))),
          //     content: Text('ds')),
        ],
      ),
    );
  }
}
