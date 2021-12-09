import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputModel {
  TextEditingController controller;
  FocusNode focusNode;
  String errorText, hintText;
  bool isSuccessful = false, obsecureText = false, isSearchText = false;
  Icon icon;
  TextInputType textInputType;
  List<TextInputFormatter> textInputFormatter;

  TextInputModel({
    String labelText,
    String hintText,
    TextInputType textInputType,
    List<TextInputFormatter> textInputFormatter,
    Icon icon,
    bool obsecureText,
    bool isSearchText,
  }) {
    focusNode = FocusNode();
    controller = TextEditingController();

    this.hintText = hintText;
    this.textInputType = textInputType;
    this.textInputFormatter = textInputFormatter;
    this.icon = icon;
    if (obsecureText == null) {
      this.obsecureText = false;
    } else {
      this.obsecureText = obsecureText;
    }
    if (isSearchText == null) {
      this.isSearchText = false;
    } else {
      this.isSearchText = isSearchText;
    }
  }
}
