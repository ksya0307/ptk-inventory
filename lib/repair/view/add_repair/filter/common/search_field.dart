import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ptk_inventory/config/colors.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onChange;
  const SearchField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.inputFormatters,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onChanged: onChange,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            color: blackLabels,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            hintText: hintText,
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}
