import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor customGreen =
      const MaterialColor(_customGreen, const <int, Color>{
    50: Color(0xFFE9F9ED),
    100: Color(0xFFC8F0D1),
    200: Color(0xFFA4E7B3),
    300: Color(0xFF7FDD94),
    400: Color(0xFF63D57D),
    500: Color(_customGreen),
    600: Color(0xFF41C95E),
    700: Color(0xFF38C253),
    800: Color(0xFF30BC49),
    900: Color(0xFF21B038),
  });

  static const int _customGreen = 0xFF48CE66;

  static const MaterialColor customBlue =
      const MaterialColor(_customBlue, const <int, Color>{
        50: Color(0xFFE8EAF6),
        100: Color(0xFFC5CBE9),
        200: Color(0xFF9FA8DA),
        300: Color(0xFF7985CB),
        400: Color(0xFF5C6BC0),
        500: Color(_customBlue),
        600: Color(0xFF394AAE),
        700: Color(0xFF3140A5),
        800: Color(0xFF29379D),
        900: Color(0xFF1B278D),
      });

  static const int _customBlue =  0xFF3F51B5;
}
