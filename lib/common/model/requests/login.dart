class LoginModelRequest {
  String username;
  String password;

  LoginModelRequest({required this.username, required this.password});

  LoginModelRequest copyWith({String? username, String? password}) {
    return LoginModelRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
