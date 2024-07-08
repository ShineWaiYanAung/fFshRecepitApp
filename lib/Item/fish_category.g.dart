// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FishNameAdapter extends TypeAdapter<FishName> {
  @override
  final int typeId = 1;

  @override
  FishName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FishName(
      name: fields[0] as String,
      data: fields[1] as double?,
      price: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FishName obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FishNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
