import 'package:flutter/material.dart';

class ColorManager {
  static ColorManager _instance;
  static ColorManager get instance {
    if (_instance == null) _instance = ColorManager._init();
    return _instance;
  }

  ColorManager._init();

  Color get blue => const Color(0xFF52CCFF);
  Color get grey => const Color(0xFFC7C7CC);
  Color get pink => const Color(0xFFFDCCC5);
  Color get white => const Color(0xFFFFFFFF);
  Color get black => const Color(0xFF000000);
}
