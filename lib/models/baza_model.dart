import 'package:hive/hive.dart';
import 'package:driver_app/hive_helper/hive_types.dart';
import 'package:driver_app/hive_helper/hive_adapters.dart';
import 'package:driver_app/hive_helper/fields/baza_model_fields.dart';
import 'package:intl/intl.dart';

part 'baza_model.g.dart';

@HiveType(typeId: HiveTypes.bazaModel, adapterName: HiveAdapters.bazaModel)
class BazaModel extends HiveObject {
  @HiveField(BazaModelFields.id)
  int id;
  @HiveField(BazaModelFields.aCity)
  String aCity;
  @HiveField(BazaModelFields.bCity)
  String bCity;
  @HiveField(BazaModelFields.baha)
  int baha;
  @HiveField(BazaModelFields.bashlanWagty)
  String bashlanWagty;
  @HiveField(BazaModelFields.gutaranWagty)
  String gutaranWagty;
  @HiveField(BazaModelFields.sene)
  String sene;
  @HiveField(BazaModelFields.isSpes)
  bool isSpes;
  @HiveField(BazaModelFields.isPogoda)
  bool isPogoda;
  @HiveField(BazaModelFields.yarygije)
  bool yarygije;
  @HiveField(BazaModelFields.dolanWagt)
  int dolanWagt;
  @HiveField(BazaModelFields.isFinished)
  bool isFinished;
  @HiveField(BazaModelFields.bashlanSene)
  String bashlanSene;
  @HiveField(BazaModelFields.gutaranSene)
  String gutaranSene;

  BazaModel({
    required this.id,
    required this.aCity,
    required this.bCity,
    required this.baha,
    required this.bashlanWagty,
    required this.gutaranWagty,
    required this.sene,
    required this.isSpes,
    required this.isPogoda,
    required this.yarygije,
    required this.dolanWagt,
    required this.isFinished,
    required this.bashlanSene,
    required this.gutaranSene,
  });

  String differenceBetweenTimes() {
    final format = DateFormat("HH:mm:ss");

    if (bashlanWagty.isEmpty || gutaranWagty.isEmpty) {
      return "00:00:00";
    }

    DateTime b = format.parse(bashlanWagty);
    DateTime g = format.parse(gutaranWagty);

    if (g.isBefore(b)) {
      g = g.add(Duration(days: 1));
    }

    Duration diff = g.difference(b);

    String two(int n) => n.toString().padLeft(2, '0');

    return "${two(diff.inHours)}:"
        "${two(diff.inMinutes % 60)}:"
        "${two(diff.inSeconds % 60)}";
  }

  num prosent() {
    if (baha >= 40)
      return ((baha / 100) * 20);
    // else if (baha == 40)
    //   return ((baha / 100) * 15); //.ceilToDouble();
    else
      return (baha / 100) * 15;
  }
}
