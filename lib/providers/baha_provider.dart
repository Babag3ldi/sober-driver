import 'package:flutter/material.dart';
import '../data/routes.dart';

class BahaProvider extends ChangeNotifier {
  int _baha = 0;
  int get baha => _baha;

  void calculateBase(String from, String to) {
    try {
      for (int i = 0; i < yollar.length; i++) {
        if (yollar[i].ispresent(from, to)) {
          // if (value1 == 'Ashgabat' && value2 == 'Ashgabat' && yarygije) {
          //   return 60;
          // } else {
          _baha = yollar[i].baha;
          // }
        }
      }
      notifyListeners();
    } catch (e) {
      _baha = 0;
      notifyListeners();
    }
  }

  void add(int price) {
    _baha += price;
    notifyListeners();
  }

  void subtract(int price) {
    _baha -= price;
    if (_baha < 0) _baha = 0;
    notifyListeners();
  }

  void reset() {
    _baha = 0;
    notifyListeners();
  }
}
