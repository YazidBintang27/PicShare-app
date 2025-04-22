import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavbar = 0;

  int get indexBottomNavbar => _indexBottomNavbar;

  set setIndexBottomNavbar(int value) {
    _indexBottomNavbar = value;
    notifyListeners();
  }
}
