import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class ThirdStepForm extends StatelessWidget {
  const ThirdStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
