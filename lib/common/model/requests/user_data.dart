class UserDataModelRequest {
  String accessToken;
  int user_id;

  UserDataModelRequest({required this.accessToken, required this.user_id});

    UserDataModelRequest copyWith({String? accessToken, int? user_id}) {
    return UserDataModelRequest(
        accessToken: accessToken ?? this.accessToken,
        user_id: user_id ?? this.user_id);
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'user_id': user_id,
    };
  }
}
