import 'package:hive/hive.dart';
import 'package:driver_app/models/baza_model.dart';

void registerAdapters() {
	Hive.registerAdapter(BazaModelAdapter());
}
