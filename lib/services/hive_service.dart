import 'package:hive/hive.dart';
import '../models/baza_model.dart';

class HiveService {
  static const String boxName = "baza";

  static Future<Box<BazaModel>> openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<BazaModel>(boxName);
    }
    return Hive.box<BazaModel>(boxName);
  }

  /// Add
  static Future<int> addTrip(BazaModel model) async {
    final box = await openBox();
    return await box.add(model);
  }

  /// Update
  static Future<void> updateTrip(int key, BazaModel model) async {
    final box = await openBox();
    await box.put(key, model);
  }

  /// Get by ID
  static Future<BazaModel?> getById(int id) async {
    final box = await openBox();
    try {
      return box.values.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all
  static Future<List<BazaModel>> getAll() async {
    final box = await openBox();
    return box.values.toList();
  }
}
