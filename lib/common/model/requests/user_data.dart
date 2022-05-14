class UserDataModelRequest {
  String accessToken;
  int userId;

  UserDataModelRequest({required this.accessToken, required this.userId});

  UserDataModelRequest copyWith({String? accessToken, int? userId}) {
    return UserDataModelRequest(
      accessToken: accessToken ?? this.accessToken,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'user_id': userId,
    };
  }
}
