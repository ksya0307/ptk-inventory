import 'package:ptk_inventory/common/model/user_roles.dart';

class ChangeUserModelRequest {
  int id;
  String? surname;
  String? name;
  String? patronymic;
  String? username;
  String? password;
  UserRole? role;
  ChangeUserModelRequest({
    required this.id,
    this.surname,
    this.name,
    this.patronymic,
    this.username,
    this.password,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'surname': surname,
      'name': name,
      'patronymic': patronymic,
      'username': username,
      'password': password,
      'role': role!.userRoleToString.toUpperCase(),
    };
  }
}
