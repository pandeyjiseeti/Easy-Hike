import 'package:easy_hike/models/profile_model.dart';
import 'package:easy_hike/services/auth.dart';
import 'package:easy_hike/services/database.dart';
import 'package:get_it/get_it.dart';

import 'models/auth_model.dart';
import 'models/question_model.dart';
import 'models/user_model.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => AuthModel());
  locator.registerLazySingleton(() => DatabaseHelper());
  // locator.registerLazySingleton(() => JobUserModel());
  locator.registerLazySingleton(() => ProfileModel());
  locator.registerLazySingleton(() => QuestionModel());
}
