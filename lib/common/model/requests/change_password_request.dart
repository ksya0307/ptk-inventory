class ChangePasswordModelRequest {
  String newPassword;
  ChangePasswordModelRequest({
    required this.newPassword,
  });
  ChangePasswordModelRequest copyWith({String? newPassword}) {
    return ChangePasswordModelRequest(
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'password': newPassword,
    };
  }
}
