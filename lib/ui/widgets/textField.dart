import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/debouncer/debouncer.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
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
      obscureText: textInputModel.obsecureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: Utility.dynamicHeight(0.02),
          horizontal: Utility.dynamicWidth(0.03),
        ),
        filled: true,
        fillColor: ColorManager.instance.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.dynamicWidth(0.03)),
          borderSide: BorderSide(color: Colors.grey[400], width: Utility.dynamicWidth(0.003)),
          gapPadding: 2,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.dynamicWidth(0.03)),
          borderSide: BorderSide(
            color: (readOnly) ? Colors.grey[500] : Colors.grey[800],
            width: 1.5,
          ),
          gapPadding: 2,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.dynamicWidth(0.03)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          gapPadding: 2,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Utility.dynamicWidth(0.03)),
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
      ),
      onChanged: (value) {
        if (function != null) {
          if (textInputModel.isSearchText) {
            Debouncer.instance.run(() {
              function();
            });
          } else {
            function();
          }
        }
      },
      onTap: onTap,
      cursorColor: ColorManager.instance.black,
      keyboardType: textInputModel.textInputType,
      textInputAction: textInputAction,
      inputFormatters: textInputModel.textInputFormatter,
    ),
  );
}
