import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptk_inventory/config/theme/colors.dart';

class InventoryNumberInput extends StatelessWidget {
  const InventoryNumberInput({Key? key}) : super(key: key);

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
