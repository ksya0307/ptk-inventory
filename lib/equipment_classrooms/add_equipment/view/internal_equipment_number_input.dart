import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ptk_inventory/config/colors.dart';

MaskTextInputFormatter internalNumberMask = MaskTextInputFormatter(
  mask: '###-##',
  filter: {"#": RegExp('[0-9]')},
);

class InternalEquipmentNumberInput extends StatelessWidget {
  const InternalEquipmentNumberInput({Key? key}) : super(key: key);
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
