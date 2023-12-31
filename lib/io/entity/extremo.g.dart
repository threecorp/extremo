// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExtremoUserEntityAdapter extends TypeAdapter<ExtremoUserEntity> {
  @override
  final int typeId = 1;

  @override
  ExtremoUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtremoUserEntity(
      id: fields[0] as int,
      email: fields[1] as String,
      dateJoined: fields[2] as DateTime?,
      isDeleted: fields[3] as bool,
      deletedAt: fields[4] as DateTime?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExtremoUserEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.dateJoined)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.deletedAt)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtremoUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
