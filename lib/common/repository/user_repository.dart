import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/http_response.dart';
import 'package:ptk_inventory/common/model/user.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';

class UserRepository {
  Future<User?> getUser() async {
    final UserHiveModel? userHiveModel = await getUserProfile();

    if (userHiveModel != null) {
      return User.fromHiveToUser(userHiveModel);
    }
    return null;
  }

  Future<HttpResponse?> changePassword() async {}
}
