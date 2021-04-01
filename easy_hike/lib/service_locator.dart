import 'package:easy_hike/services/auth.dart';
import 'package:get_it/get_it.dart';

import 'models/auth_model.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => AuthModel());
}
