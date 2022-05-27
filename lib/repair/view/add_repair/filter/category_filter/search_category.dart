import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class SearchCategory extends StatelessWidget {
  const SearchCategory({Key? key}) : super(key: key);

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
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            color: blackLabels,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: greyDark,
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
            hintText: 'Смартфон',
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}
