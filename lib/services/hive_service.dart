import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/baza_model.dart';

class HiveService {
  static const String boxName = "baza";

  /// Open box
  static Future<Box<BazaModel>> _openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BazaModelAdapter());
    }

    if (!Hive.isBoxOpen(boxName)) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      return await Hive.openBox<BazaModel>(boxName);
    }

    return Hive.box<BazaModel>(boxName);
  }

  /// ADD
  static Future<int> add(BazaModel model) async {
    final box = await _openBox();
    return await box.add(model);
  }

  static Future<void> update(BazaModel model) async {
    final box = await _openBox();

    // Köne obýektiň key-ni tap
    final key = box.keys.firstWhere((k) {
      final item = box.get(k);
      return item?.id == model.id;
    }, orElse: () => null);

    if (key == null) {
      print("❌ Update error: model tapylmady!");
      return;
    }

    // Täze obýekt döredip ýaz (öz instance-yny gaýtadan goýma!)
    final newModel = BazaModel(
      id: model.id,
      aCity: model.aCity,
      bCity: model.bCity,
      baha: model.baha,
      bashlanWagty: model.bashlanWagty,
      bashlanSene: model.bashlanSene,
      gutaranWagty: model.gutaranWagty,
      gutaranSene: model.gutaranSene,
      sene: model.sene,
      isSpes: model.isSpes,
      isPogoda: model.isPogoda,
      yarygije: model.yarygije,
      dolanWagt: model.dolanWagt,
      isFinished: model.isFinished,
    );

    await box.put(key, newModel);
  }

  /// GET ALL
  static Future<List<BazaModel>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// GET BY ID
  static Future<BazaModel?> getById(int id) async {
    final box = await _openBox();
    try {
      return box.values.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// DELETE ALL (optional)
  static Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
