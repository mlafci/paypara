import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';

Widget button({
  Function function,
  String text,
  bool isPrimary,
  @required bool loading,
}) {
  return TextButton(
    onPressed: function,
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(
        Size(
          Utility.dynamicWidth(0.9),
          Utility.dynamicHeight(0.065),
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            width: Utility.dynamicWidth(0.005),
            color: (function != null) ? ColorManager.instance.blue : ColorManager.instance.grey,
          ),
          borderRadius: BorderRadius.circular(Utility.dynamicWidth(0.03)),
        ),
      ),
      overlayColor: MaterialStateProperty.all(
        (isPrimary) ? ColorManager.instance.white.withOpacity(0.2) : ColorManager.instance.blue.withOpacity(0.2),
      ),
      backgroundColor: MaterialStateProperty.all(
        (function != null && isPrimary)
            ? ColorManager.instance.blue
            : (function != null && !isPrimary)
                ? ColorManager.instance.white
                : ColorManager.instance.grey,
      ),
    ),
    child: (loading)
        ? CircularProgressIndicator(
            color: ColorManager.instance.white,
          )
        : Text(
            text,
            style: (isPrimary || function == null) ? TextStyleManager.instance.headline4WhiteMedium : TextStyleManager.instance.headline4WhiteMedium,
          ),
  );
}
