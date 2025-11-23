// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baza_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BazaModelAdapter extends TypeAdapter<BazaModel> {
  @override
  final int typeId = 0;

  @override
  BazaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BazaModel(
      id: fields[0] as int,
      aCity: fields[1] as String,
      bCity: fields[2] as String,
      baha: fields[3] as int,
      bashlanWagty: fields[4] as String,
      gutaranWagty: fields[5] as String,
      sene: fields[6] as String,
      isSpes: fields[7] as bool,
      isPogoda: fields[8] as bool,
      yarygije: fields[9] as bool,
      dolanWagt: fields[10] as int,
      isFinished: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BazaModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.aCity)
      ..writeByte(2)
      ..write(obj.bCity)
      ..writeByte(3)
      ..write(obj.baha)
      ..writeByte(4)
      ..write(obj.bashlanWagty)
      ..writeByte(5)
      ..write(obj.gutaranWagty)
      ..writeByte(6)
      ..write(obj.sene)
      ..writeByte(7)
      ..write(obj.isSpes)
      ..writeByte(8)
      ..write(obj.isPogoda)
      ..writeByte(9)
      ..write(obj.yarygije)
      ..writeByte(10)
      ..write(obj.dolanWagt)
      ..writeByte(11)
      ..write(obj.isFinished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BazaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
