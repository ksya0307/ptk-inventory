class ChangePasswordModelRequest {
  int userId;
  String newPassword;
  ChangePasswordModelRequest({
    required this.userId,
    required this.newPassword,
  });
  ChangePasswordModelRequest copyWith({int? userId, String? newPassword}) {
    return ChangePasswordModelRequest(
      userId: userId ?? this.userId,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'password': newPassword,
    };
  }
}
