// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      name: fields[1] as String,
      profilePicture: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      position: fields[5] as String,
      password: fields[6] as String,
      isAuthenticated: fields[7] as bool,
      isFingerPrintSaved: fields[8] as bool,
      token: fields[9] as String,
      expiresIn: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.profilePicture)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.isAuthenticated)
      ..writeByte(8)
      ..write(obj.isFingerPrintSaved)
      ..writeByte(9)
      ..write(obj.token)
      ..writeByte(10)
      ..write(obj.expiresIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
