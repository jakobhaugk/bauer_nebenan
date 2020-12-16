import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int _index = 0;

  set i(index) {
    _index = index;
    notifyListeners();
  }

  get i => _index;
}
