import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue("ADMIN")
  admin,
  @JsonValue("MODERATOR")
  moderator,
  @JsonValue("TEACHER")
  teacher,
  @JsonValue("COMMON")
  common
}

// create extension on UserRole to get the string representation of the role name in the enum class
extension UserRoleExtension on UserRole {
  String get userRoleToString {
    switch (this) {
      case UserRole.moderator:
        return 'moderator';
      case UserRole.teacher:
        return 'teacher';
      case UserRole.admin:
        return 'admin';
      default:
        return 'common';
    }
  }
}
