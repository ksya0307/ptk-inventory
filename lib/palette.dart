import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor customGreen =
      MaterialColor(_customGreen, <int, Color>{
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
      MaterialColor(_customBlue, <int, Color>{
    50: Color(0xFFE8EAF6),
    100: Color(0xFFC5CBE9),
    200: Color(0xFF9FA8DA),
    300: Color(0xFF7985CB),
    400: Color(0xFF5C6BC0),
    500: Color(_customBlue),
    600: Color(0xFF394AAE),
    700: Color(0xFF3140A5),
    800: Color(0xFF29379D),
    900: Color(0xFF002FA7),
  });

  static const int _customBlue = 0xFF002FA7;
}

const Color dark = Color(0xFF060F1C);
const Color secondaryDark = Color(0xFF130F26);
const Color light = Color(0xFFF1F1F1);
const Color secondaryLight = Color(0xFFEDF3FE);
const Color white = Color(0xFFFFFFFF);
const Color orange = Color(0xFFFF7F00);
const Color red = Color(0xFFDA0000);
const Color green = Color(0xFF49C969);
const Color skyBlue = Color(0xFF2CCEFF);
const Color deepBlue = Color(0xFF3253FF);
const Color grey = Color(0xFF9D9D9D);
const Color lightGrey = Color(0xFFE5E5E5);
const Color yellow = Color(0xFFFFC107);
const Color shadowColor = Color(0x14191919);
const Color customAppBlue = Color(0xFF002FA7);

const LinearGradient redGradient = LinearGradient(
  colors: [
    Color(0xFFB00000),
    Color(0xFFDA0000),
    Color(0xFFDA0000),
  ],
);

// green gradient background: linear-gradient(90deg, #0E9A31 0%, #12A235 51.7%, #0EC13B 100%);
const LinearGradient greenGradient = LinearGradient(
  colors: [
    Color(0xFF0E9A31),
    Color(0xFF12A235),
    Color(0xFF0EC13B),
  ],
);

// orange gradient background: linear-gradient(90deg, #F15A24 0%, #F68F1F 98.29%, #F68F1F 98.29%);
LinearGradient orangeGradient = LinearGradient(
  colors: [
    const Color(0xFFF15A24),
    const Color(0xFFF68F1F).withOpacity(0.9829),
    const Color(0xFFF68F1F)..withOpacity(0.9829),
  ],
);

// sky blue gradient background: linear-gradient(89.61deg, #2CCEFF 0.39%, #30AAFF 0.4%, #30AAFF 2.09%, #30ABFF 2.1%, #30ACFF 4.22%, #30ADFF 6.78%, #31B5FF 22.52%, #31B9FF 31.03%, #32C3FF 51.87%, #32C6FF 57.83%, #33C9FF 69.32%, #33CDFF 77.4%, #33CEFF 82.07%, #33CEFF 82.07%, #33CFFF 82.08%);

const LinearGradient skyBlueGradient = LinearGradient(
  colors: [
    Color(0xFF30AAFF),
    Color(0xFF30ABFF),
    Color(0xFF30ADFF),
    Color(0xFF31B5FF),
    Color(0xFF31B9FF),
    Color(0xFF32C3FF),
    Color(0xFF32C6FF),
    Color(0xFF33C9FF),
  ],
);

// gray gradient background: linear-gradient(90deg, #9D9D9D 0%, #E5E5E5 98.29%, #E5E5E5 98.29%);
const LinearGradient grayGradient = LinearGradient(
  colors: [
    lightGrey,
    lightGrey,
  ],
);

// light gradient background: linear-gradient(90deg, #F1F1F1 0%, #EDF3FE 98.29%, #EDF3FE 98.29%);
const LinearGradient lightGradient = LinearGradient(
  colors: [
    light,
    light,
  ],
);

// dark gradient background: linear-gradient(90deg, #252525 0%, #3D3C3C 49.96%, #585858 98.28%);
const LinearGradient darkGradient = LinearGradient(
  colors: [
    Color(0xFF252525),
    Color(0xFF3D3C3C),
    Color(0xFF585858),
  ],
);

// create yellowGradient background: linear-gradient(90deg, #FFC107 0%, #FFD54F 98.29%, #FFD54F 98.29%);
const LinearGradient yellowGradient = LinearGradient(
  colors: [
    Color(0xFFFFC107),
    Color(0xFFFFD54F),
    Color(0xFFFFD54F),
  ],
);
