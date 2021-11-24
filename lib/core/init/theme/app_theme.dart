import 'package:flutter/material.dart';
import 'package:paypara/core/init/theme/color_manager.dart';

class AppTheme {
  static AppTheme _instance;
  static AppTheme get instance {
    if (_instance == null) _instance = AppTheme._init();
    return _instance;
  }

  AppTheme._init();

  String fontRegular = "SFREGULAR",
      fontMedium = "SFMEDIUM",
      fontBold = "SFBOLD";

  ThemeData get theme => ThemeData(
        fontFamily: fontRegular,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorManager.instance.green,
          foregroundColor: ColorManager.instance.white,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: ColorManager.instance.lightGrey,
      );
}
