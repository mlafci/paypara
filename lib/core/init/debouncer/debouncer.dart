import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  static Debouncer _instance;
  static Debouncer get instance {
    if (_instance == null) _instance = Debouncer._init();
    return _instance;
  }

  Debouncer._init();

  final int milliseconds = 750;
  VoidCallback action;
  Timer _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
