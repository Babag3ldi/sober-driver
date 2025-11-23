import 'package:flutter/material.dart';

class BahaProvider extends ChangeNotifier {
  int _baha = 0;

  int get baha => _baha;

  /// Reset to zero
  void reset() {
    _baha = 0;
    notifyListeners();
  }

  /// Set new value
  void setBaha(int value) {
    _baha = value;
    notifyListeners();
  }

  /// Add
  void add(int value) {
    _baha += value;
    notifyListeners();
  }

  /// Remove
  void subtract(int value) {
    _baha -= value;
    if (_baha < 0) _baha = 0;
    notifyListeners();
  }

  /// Replace old → new route price
  void replaceRoutePrice(int oldPrice, int newPrice) {
    _baha = _baha - oldPrice + newPrice;
    notifyListeners();
  }
}
