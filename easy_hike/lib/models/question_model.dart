import 'package:easy_hike/services/database.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class QuestionModel extends Model {
  Map<String, dynamic> profileInformation = {};
  List<Map<String, dynamic>> workExperience = [];

  final DatabaseHelper _databaseService = locator<DatabaseHelper>();

  List<Map<String, dynamic>> get workExp => workExperience;

  set workExp(List<Map<String, dynamic>> workExp) => workExperience = workExp;

  Map<String, dynamic> get profileInfo => profileInformation;

  set profileInfo(Map<String, dynamic> profileInfo) =>
      profileInformation = profileInfo;

  Future<void> setData(String uid) async {
    _databaseService.setUserData(data: profileInformation, uid: uid);
  }
}
