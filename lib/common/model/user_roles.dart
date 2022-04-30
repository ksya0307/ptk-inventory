enum UserRole { admin, moderator, reader, common }

// create extension on UserRole to get the string representation of the role name in the enum class
extension UserRoleExtension on UserRole {
  String get userRoleToString {
    switch (this) {
      case UserRole.moderator:
        return 'MODERATOR';
      case UserRole.reader:
        return 'READER';
      case UserRole.admin:
        return 'ADMIN';
      default:
        return 'COMMON';
    }
  }
}
