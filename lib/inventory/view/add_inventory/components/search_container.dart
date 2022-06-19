import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/palette.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: BlocBuilder<ClassroomEquipmentBloc,
                    ClassroomEquipmentState>(
                  buildWhen: (previous, current) =>
                      previous.searchText != current.searchText,
                  builder: (context, state) {
                    return TextFormField(
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: blackLabels,
                      ),
                      onChanged: (inventoryNumber) {
                        context
                            .read<ClassroomEquipmentBloc>()
                            .add(ClassroomEquipmentSearch(inventoryNumber));
                      },
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
