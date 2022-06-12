import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ptk_inventory/config/colors.dart';

class ChooseDateButton extends StatefulWidget {
  const ChooseDateButton({
    Key? key,
    required this.calendarText,
    required this.onPress,
    required this.date,
  }) : super(key: key);
  final String calendarText;
  final void Function()? onPress;
  final DateTime? date;

  @override
  State<ChooseDateButton> createState() => _ChooseDateButtonState();
}

class _ChooseDateButtonState extends State<ChooseDateButton> {
  @override
  void initState() {
    super.initState();
  }

  int currentStep = 0;

  String getText() {
    if (widget.date == null) {
      return 'Нажмите для выбора даты';
    } else {
      return '${widget.date?.day} - ${DateFormat('MM').format(widget.date!)} - ${widget.date?.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
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
      onPressed: widget.onPress,
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
}
/*
() async {
        final initDate = DateTime.now();
        final DateTime? newDate = await showDatePicker(
          cancelText: "Отмена",
          confirmText: "Выбрать",
          helpText: widget.calendarText,
          context: context,
          initialDate: initDate,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
        );
        // if 'Cancel' => null
        if (newDate == null) return;
        //of Ok =>DateTime
        setState(() {
          date = newDate;
        });
      }
 */
