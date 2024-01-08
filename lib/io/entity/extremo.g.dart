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

class ExtremoArtifactEntityAdapter extends TypeAdapter<ExtremoArtifactEntity> {
  @override
  final int typeId = 2;

  @override
  ExtremoArtifactEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtremoArtifactEntity(
      id: fields[0] as int,
      userFk: fields[1] as int,
      title: fields[2] as String,
      content: fields[3] as String,
      summary: fields[4] as String,
      status: fields[5] as String,
      publishFrom: fields[6] as DateTime?,
      publishUntil: fields[7] as DateTime?,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExtremoArtifactEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userFk)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.summary)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.publishFrom)
      ..writeByte(7)
      ..write(obj.publishUntil)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtremoArtifactEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
