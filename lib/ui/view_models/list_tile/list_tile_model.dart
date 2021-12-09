import 'package:flutter/material.dart';

class ListTileModel {
  Widget leading;
  Widget trailing;
  bool isThreeLine;
  bool dense;
  ListTileStyle style;
  Color selectedColor;
  Color tileColor;
  ShapeBorder shapeBorder;
  Text title;
  Text subtitle;

  ListTileModel({
    Widget leading,
    Widget trailing,
    Text subtitle,
    Text title,
  }) {
    this.leading = leading;
    this.trailing = trailing;
    this.subtitle = subtitle;
    this.title = title;
  }
}
