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

  // headline2
  TextStyle get headline2GreenBold => TextStyle(
        color: ColorManager.instance.green,
        fontSize: headline2,
        fontFamily: bold,
      );

  // headline3
  TextStyle get headline3WhiteBold => TextStyle(
        color: ColorManager.instance.white,
        fontSize: headline3,
        fontFamily: bold,
      );

  // headline4
  TextStyle get headline4WhiteMedium => TextStyle(
        color: ColorManager.instance.white,
        fontSize: headline4,
        fontFamily: medium,
      );
  TextStyle get headline4GreenMedium => TextStyle(
        color: ColorManager.instance.green,
        fontSize: headline4,
        fontFamily: medium,
      );

  // headline5
  TextStyle get headline5BlackRegular => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline5,
        fontFamily: regular,
      );

  TextStyle get headline5BlackBold => TextStyle(
        color: ColorManager.instance.black,
        fontSize: headline5,
        fontFamily: bold,
      );

  TextStyle get headline5GreyRegular => TextStyle(
        color: ColorManager.instance.grey,
        fontSize: headline5,
        fontFamily: regular,
      );

  TextStyle get headline5WhiteMedium => TextStyle(
        color: ColorManager.instance.white,
        fontSize: headline5,
        fontFamily: medium,
      );

  TextStyle get headline5GreenMedium => TextStyle(
        color: ColorManager.instance.green,
        fontSize: headline5,
        fontFamily: medium,
      );

  // body1
  TextStyle get body1GreyRegular => TextStyle(
        color: ColorManager.instance.grey,
        fontSize: body1,
        fontFamily: regular,
      );
  TextStyle get body1BlackRegular => TextStyle(
        color: ColorManager.instance.black,
        fontSize: body1,
        fontFamily: regular,
      );

  // body2
  TextStyle get body2BlackBold => TextStyle(
        color: ColorManager.instance.black,
        fontSize: body2,
        fontFamily: bold,
      );

  TextStyle get body2BlackRegular => TextStyle(
        color: ColorManager.instance.black,
        fontSize: body2,
        fontFamily: regular,
      );
  TextStyle get body2GreyMedium => TextStyle(
        color: ColorManager.instance.grey,
        fontSize: body2,
        fontFamily: medium,
      );
  TextStyle get body2DarkGreenMedium => TextStyle(
        color: ColorManager.instance.darkGreen,
        fontSize: body2,
        fontFamily: medium,
      );
  TextStyle get body2GreenMedium => TextStyle(
        color: ColorManager.instance.green,
        fontSize: body2,
        fontFamily: medium,
      );

  TextStyle get body2GreenRegular => TextStyle(
        color: ColorManager.instance.green,
        fontSize: body2,
        fontFamily: regular,
      );
  TextStyle get body2DarkGreyMedium => TextStyle(
        color: ColorManager.instance.darkGrey,
        fontSize: body2,
        fontFamily: medium,
      );
}
