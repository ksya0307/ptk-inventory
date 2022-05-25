import 'package:ptk_inventory/common/model/user_roles.dart';

class UpdateUserModelRequest {
  final String? surname;
  final String? name;
  final String? patronymic;
  final String? username;
  final String? password;
  final UserRole? role;
  UpdateUserModelRequest({
    this.surname,
    this.name,
    this.patronymic,
    this.username,
    this.password,
    this.role,
  });
}
