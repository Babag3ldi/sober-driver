import 'package:flutter/material.dart';
import '../models/baza_model.dart';
import '../services/hive_service.dart';

class BazaProvider extends ChangeNotifier {
  List<BazaModel> currentBaza = [];
  BazaModel? _activeRide;
  num totalPrice = 0;

  BazaModel? get activeRide => _activeRide;

  bool get isRunning => _activeRide != null;

  Future<void> loadFromHive() async {
    currentBaza = await HiveService.getAll();
    print(currentBaza.length);
    summaHasapla();
    print(totalPrice);
    notifyListeners();
  }

  void setActiveRide(BazaModel model) {
    _activeRide = model;
    notifyListeners();
  }

  void clearActive() {
    _activeRide = null;
    notifyListeners();
  }

  summaHasapla() {
    totalPrice = 0;
    for (var item in currentBaza) {
      totalPrice += (item.baha * 0.20);
    }
  }

  clearTheCash() async {
    currentBaza.clear();
    totalPrice = 0;
    notifyListeners();
  }

  deleteOneItem(int oneItemIndex) async {
    currentBaza.removeAt(oneItemIndex);
    summaHasapla();
    notifyListeners();
  }
}

