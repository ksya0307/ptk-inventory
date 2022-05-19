import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';

class HeaderModel {
  // "Authorization": "Bearer AccessToken"

  String token;
  HeaderModel(this.token);

  Map<String, String> toMap() => {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      };

  static Future<String> getAccessToken() async {
    final data = await getUserProfile();

    return data!.accessToken;
  }
}
