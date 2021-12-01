import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';

Widget textField({
  @required TextInputModel textInputModel,
  TextInputAction textInputAction,
  Function function,
  Function onTap,
  bool readOnly = false,
}) {
  return Container(
    width: Utility.dynamicWidth(0.9),
    child: TextField(
      readOnly: readOnly,
      controller: textInputModel.controller,
      focusNode: textInputModel.focusNode,
      //style: TextStyleManager.instance.headline5BlackRegular,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: Utility.dynamicHeight(0.02),
          horizontal: Utility.dynamicWidth(0.03),
        ),
        filled: true,
        fillColor: ColorManager.instance.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.borderRadius),
          borderSide: BorderSide(
            color: ColorManager.instance.grey,
          ),
          gapPadding: 2,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.borderRadius),
          borderSide: BorderSide(
            color: (readOnly)
                ? ColorManager.instance.grey
                : ColorManager.instance.blue,
            width: 1.5,
          ),
          gapPadding: 2,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          gapPadding: 2,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          gapPadding: 2,
        ),
        prefixIcon: textInputModel.icon,
        suffixIcon: (textInputModel.errorText != null)
            ? Icon(
                CupertinoIcons.exclamationmark_circle,
                color: Colors.red,
              )
            : null,
        errorText: textInputModel.errorText,
        hintText: textInputModel.hintText,
        //hintStyle: TextStyleManager.instance.headline5GreyRegular,
      ),
      onChanged: (value) {
        function();
      },
      onTap: onTap,
      cursorColor: ColorManager.instance.black,
      keyboardType: textInputModel.textInputType,
      textInputAction: textInputAction,
      inputFormatters: textInputModel.textInputFormatter,
    ),
  );
}
