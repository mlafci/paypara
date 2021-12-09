import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';

class TextStyleManager {
  static TextStyleManager _instance;
  static TextStyleManager get instance {
    if (_instance == null) _instance = TextStyleManager._init();
    return _instance;
  }

  TextStyleManager._init();

  double get headline1 => Utility.dynamicHeight(0.04);
  double get headline2 => Utility.dynamicHeight(0.03);
  double get headline3 => Utility.dynamicHeight(0.025);
  double get headline4 => Utility.dynamicHeight(0.022);
  double get headline5 => Utility.dynamicHeight(0.02);
  double get body1 => Utility.dynamicHeight(0.018);
  double get body2 => Utility.dynamicHeight(0.016);

  String get regular => "SFREGULAR";
  String get medium => "SFMEDIUM";
  String get bold => "SFBOLD";

  // headline1
  TextStyle get headline1BlackBold => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline1,
        fontFamily: bold,
      );
// h1
  TextStyle get headline1BlackMedium => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline1,
        fontFamily: medium,
      );

// h2
  TextStyle get headline2BlackMedium => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline2,
        fontFamily: medium,
      );

  // h3
  TextStyle get headline3BlackMedium => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline3,
        fontFamily: medium,
      );

// h3 bold
  TextStyle get headline3BlackBold => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline3,
        fontFamily: bold,
      );

  // headline4
  TextStyle get headline4WhiteMedium => TextStyle(
        color: ColorManager.instance.white,
        fontSize: headline4,
        fontFamily: medium,
      );
  TextStyle get headline4BlackMedium => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline4,
        fontFamily: medium,
      );

  TextStyle get headline5BlackRegular => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline5,
        fontFamily: regular,
      );
  // headline5
  TextStyle get headline5WhiteMedium => TextStyle(
        color: ColorManager.instance.white,
        fontSize: headline5,
        fontFamily: medium,
      );
}
