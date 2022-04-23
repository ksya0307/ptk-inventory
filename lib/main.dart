import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptk_inventory/user_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  FlutterServicesBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  HydratedBlocOverrides.runZoned(
      () => runApp(App(userRepository: UserRepository())),
      blocObserver: UserBlocObserver(),
      storage: storage);
}
