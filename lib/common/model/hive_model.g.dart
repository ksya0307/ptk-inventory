// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 0;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      id: fields[0] as int,
      surname: fields[1] as String,
      name: fields[2] as String,
      patronymic: fields[3] as String,
      username: fields[4] as String,
      userRole: fields[5] as String,
      accessToken: fields[6] as String,
      refreshToken: fields[7] as String,
      lastTimeUpdated: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.patronymic)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.userRole)
      ..writeByte(6)
      ..write(obj.accessToken)
      ..writeByte(7)
      ..write(obj.refreshToken)
      ..writeByte(8)
      ..write(obj.lastTimeUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHiveModel _$UserHiveModelFromJson(Map<String, dynamic> json) =>
    UserHiveModel(
      id: json['id'] as int,
      surname: json['surname'] as String,
      name: json['name'] as String,
      patronymic: json['patronymic'] as String,
      username: json['username'] as String,
      userRole: json['userRole'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      lastTimeUpdated: DateTime.parse(json['lastTimeUpdated'] as String),
    );

Map<String, dynamic> _$UserHiveModelToJson(UserHiveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surname': instance.surname,
      'name': instance.name,
      'patronymic': instance.patronymic,
      'username': instance.username,
      'userRole': instance.userRole,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'lastTimeUpdated': instance.lastTimeUpdated.toIso8601String(),
    };
