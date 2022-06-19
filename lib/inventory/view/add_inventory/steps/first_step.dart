import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/common/component/choose_date.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/given_toggle.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/inventory_number_form.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/search_add_container.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/property_inventory.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom_filter/filter_classroom_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/inventory_number_chips.dart';

class FirstStepForm extends StatefulWidget {
  const FirstStepForm({Key? key}) : super(key: key);

  @override
  State<FirstStepForm> createState() => _FirstStepFormState();
}

class _FirstStepFormState extends State<FirstStepForm> {
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InventoryProperty(
          property: "Выберите инвентарный номер",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 8,
        ),
        const InventoryProperty(
          property: "или найдите",
          paddingLeft: 16,
          paddingBottom: 4,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        const SearchAddContainer(),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: InventoryNumberForm(
            bloc: InventoryBloc,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        const InventoryProperty(
          property: "Дата принятия к учету",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ChooseDateButton(
            calendarText: 'Дата принятия к учету',
            onPress: () async {
              final initDate = DateTime.now();

              final DateTime? newDate = await showDatePicker(
                cancelText: "Отмена",
                confirmText: "Выбрать",
                helpText: "Дата составления акта приема-передачи",
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

                final newNewDate = DateTime(
                  date!.year,
                  date!.month,
                  date!.day,
                  DateTime.now().hour,
                  DateTime.now().minute,
                  DateTime.now().second,
                  DateTime.now().millisecond,
                  DateTime.now().microsecond,
                );

                context
                    .read<InventoryBloc>()
                    .add(InventoryDateSelected(dateTime: newNewDate));
              });
            },
            date: date,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "${DateTime.now().day}.${DateFormat('MM').format(DateTime.now())}.${DateTime.now().year} по умолчанию",
            style: const TextStyle(
              color: greyDark,
              fontFamily: 'Rubik',
              fontSize: 14,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        const InventoryProperty(
          property: "Закуплено для аудитории",
          paddingLeft: 16,
          paddingBottom: 4,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: FilterClassroomForm(
            bloc: InventoryBloc,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        const InventoryProperty(
          property: "Выдано",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: BlocBuilder<InventoryBloc, InventoryState>(
            buildWhen: (previous, current) => previous.given != current.given,
            builder: (context, state) {
              return GivenToggle(
                onToggle: (given) {
                  if (given == 0) {
                    context
                        .read<InventoryBloc>()
                        .add(const InventoryGivenChanged(given: false));
                  } else if (given == 1) {
                    context
                        .read<InventoryBloc>()
                        .add(const InventoryGivenChanged(given: true));
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
