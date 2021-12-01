import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputModel {
  TextEditingController controller;
  FocusNode focusNode;
  String errorText, hintText;
  bool isSuccessful = false;
  Icon icon;
  TextInputType textInputType;
  List<TextInputFormatter> textInputFormatter;

  TextInputModel({
    String labelText,
    String hintText,
    TextInputType textInputType,
    List<TextInputFormatter> textInputFormatter,
    Icon icon,
  }) {
    focusNode = FocusNode();
    controller = TextEditingController();

    this.hintText = hintText;
    this.textInputType = textInputType;
    this.textInputFormatter = textInputFormatter;
    this.icon = icon;
  }
}
