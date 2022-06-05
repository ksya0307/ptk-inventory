import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class PasswordInput extends StatefulWidget {
  final String? initialValue;
  final Function(String)? onChange;
  final String errorText;
  final bool propertyInvalid;
  final String hintText;
  const PasswordInput({
    Key? key,
    this.initialValue,
    this.onChange,
    required this.errorText,
    required this.propertyInvalid,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInput();
}

class _PasswordInput extends State<PasswordInput> {
  bool _obscureText = true;

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      cursorColor: Theme.of(context).primaryColor,
      minLines: 1,
      obscureText: _obscureText,
      style: const TextStyle(
        fontFamily: 'Rubik',
        fontSize: 18,
        color: blackInput,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
        errorText: widget.propertyInvalid ? widget.errorText : null,
        errorStyle: const TextStyle(
          color: redCustom,
          fontFamily: 'Rubik',
        ),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          color: const Color.fromRGBO(156, 156, 156, 1.0),
          onPressed: _passwordVisibility,
          icon: Icon(
            !_obscureText
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
        hintStyle: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          color: greyDark,
        ),
        border: const OutlineInputBorder(),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redCustom, width: 1.5),
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
    );
  }
}
