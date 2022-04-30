class HeaderModel {
  // "Authorization": "Bearer AccessToken

  String token;
  HeaderModel({required this.token});

  Map<String, String> toMap() => {
        "Authorization": "Bearer $token",
      };
}
