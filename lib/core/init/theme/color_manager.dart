import 'package:flutter/material.dart';

class ColorManager {
  static ColorManager _instance;
  static ColorManager get instance {
    if (_instance == null) _instance = ColorManager._init();
    return _instance;
  }

  ColorManager._init();

  Color get green => const Color(0xFF359503);
  Color get darkGreen => const Color(0xFF34763C);
  Color get lightGrey => const Color(0xFFF2F2F7);
  Color get grey => const Color(0xFFC7C7CC);
  Color get darkGrey => const Color(0xFF9E9E9E);
  Color get white => const Color(0xFFFFFFFF);
  Color get black => const Color(0xFF000000);
  Color get blueGrey => const Color(0xFF37474F);
}
