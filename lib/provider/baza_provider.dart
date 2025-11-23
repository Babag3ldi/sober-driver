import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/baza_model.dart';
import '../services/hive_service.dart';
import '../services/sms_service.dart';

class BazaProvider extends ChangeNotifier {
  BazaModel? activeTrip;
  int? activeKey;

  bool get isRunning => activeTrip != null;

  /// START -------------------------------------------------------------------
  Future<void> startTrip({
    required String from,
    required String to,
    required int price,
    required bool isSpes,
    required bool isPogoda,
  }) async {
    final now = DateTime.now();

    final newTrip = BazaModel(
      id: now.millisecondsSinceEpoch,
      aCity: from,
      bCity: to,
      baha: price,
      bashlanWagty: DateFormat("HH:mm:ss").format(now),
      gutaranWagty: "",
      sene: DateFormat("dd-MM-yyyy").format(now),
      isSpes: isSpes,
      isPogoda: isPogoda,
      yarygije: false,
      dolanWagt: 30,
      isFinished: false,
    );

    final key = await HiveService.addTrip(newTrip);

    activeTrip = newTrip;
    activeKey = key;

    SMSService.sendStart(from);

    notifyListeners();
  }

  /// FINISH ------------------------------------------------------------------
  Future<void> finishTrip(int finalPrice, String duration) async {
    if (activeTrip == null || activeKey == null) return;

    final now = DateTime.now();

    final updated = BazaModel(
      id: activeTrip!.id,
      aCity: activeTrip!.aCity,
      bCity: activeTrip!.bCity,
      baha: finalPrice,
      bashlanWagty: activeTrip!.bashlanWagty,
      gutaranWagty: DateFormat("HH:mm:ss").format(now),
      sene: activeTrip!.sene,
      isSpes: activeTrip!.isSpes,
      isPogoda: activeTrip!.isPogoda,
      yarygije: activeTrip!.yarygije,
      dolanWagt: activeTrip!.dolanWagt,
      isFinished: true,
    );

    await HiveService.updateTrip(activeKey!, updated);

    SMSService.sendFinish(
      updated.aCity,
      updated.bCity,
      updated.baha,
      duration,
    );

    activeTrip = null;
    activeKey = null;

    notifyListeners();
  }

  /// ALL TRIPS ---------------------------------------------------------------
  Future<List<BazaModel>> getAllTrips() async {
    return await HiveService.getAll();
  }
}
