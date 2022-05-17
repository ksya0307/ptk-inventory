class SignUpModelRequest {
  String surname;
  String name;
  String? patronymic;
  String username;
  String password;

  SignUpModelRequest({
    required this.surname,
    required this.name,
    this.patronymic,
    required this.username,
    required this.password,
  });

  SignUpModelRequest copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? username,
    String? password,
  }) {
    return SignUpModelRequest(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      patronymic: patronymic ?? this.patronymic,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'surname': surname,
      'name': name,
      'patronymic': patronymic,
      'username': username,
      'password': password,
    };
  }
}
