import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class PropertyInput extends StatelessWidget {
  const PropertyInput({
    Key? key,
    required this.initialValue,
    this.onChange,
    this.errorText = '',
    this.propertyInvalid = false,
    required this.hintText,
  }) : super(key: key);
  final String? initialValue;
  final Function(String)? onChange;
  final String errorText;
  final bool propertyInvalid;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChange,
        cursorColor: Theme.of(context).primaryColor,
        minLines: 1,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          color: blackInput,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(Icons.edit_rounded),
          labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
          errorText: propertyInvalid ? errorText : null,
          errorStyle: const TextStyle(
            color: redCustom,
            fontFamily: 'Rubik',
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
          hintStyle: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: greyDark,
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
              color: blueInputFocuced,
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
        ),
      ),
    );
  }
}
