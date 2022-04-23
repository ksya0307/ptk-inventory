import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//@JsonSerializable to label classes which can be serialized
//@JsonKey to provide string representations of field names
//@JsonValue to provide string representations of field values

enum UserRole {
  @JsonValue('MODERATOR')
  MODERATOR,
  @JsonValue('READER')
  READER
}
extension UserRoleX on UserRole{
  String? get role => _$UserRoleEnumMap[this];
}


///Модель для [User] от Api endpoints responses!!!
// serialize and deserialize our models для того чтобы работать с API данными
@JsonSerializable()
class User {
  final int id;
  final String surname;
  final String name;
  final String patronymic;
  final String username;
  final UserRole role;

  const User(this.id, this.surname, this.name, this.patronymic, this.username,
      this.role);

  //для  создания объекта из Api Json ответа
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
