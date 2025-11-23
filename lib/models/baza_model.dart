import 'package:hive/hive.dart';
import 'package:driver_app/hive_helper/hive_types.dart';
import 'package:driver_app/hive_helper/hive_adapters.dart';
import 'package:driver_app/hive_helper/fields/baza_model_fields.dart';


part 'baza_model.g.dart';


@HiveType(typeId: HiveTypes.bazaModel, adapterName: HiveAdapters.bazaModel)
class BazaModel extends HiveObject{
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
  });
}