import 'package:ptk_inventory/common/model/user_roles.dart';

class SignUpModelRequest {
  String surname;
  String name;
  String? patronymic;
  String username;
  String password;
  UserRole role;

  SignUpModelRequest({
    required this.surname,
    required this.name,
    this.patronymic,
    required this.username,
    required this.password,
    this.role = UserRole.common,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'surname': surname,
      'name': name,
      'patronymic': patronymic,
      'username': username,
      'password': password,
      'role': role.userRoleToString.toUpperCase(),
    };
  }

  SignUpModelRequest copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? username,
    String? password,
    UserRole? role,
  }) {
    return SignUpModelRequest(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
