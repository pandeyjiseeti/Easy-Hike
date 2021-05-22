import 'package:easy_hike/models/user_model.dart';
import 'package:easy_hike/services/auth.dart';
import 'package:easy_hike/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ProfileModel extends Model {
  static ProfileModel of(BuildContext context) =>
      ScopedModel.of<ProfileModel>(context);
  JobUser jobUser;
  final Auth _authService = locator<Auth>();
  final DatabaseHelper _databaseService = locator<DatabaseHelper>();

  Stream<User> get user => _authService.user;

  String uid;

  Future<void> setUID() async {
    uid = (await user.take(1).toList())[0].uid.toString();
  }

  Future<JobUser> setData() async {
    await setUID();
    await _databaseService.getUserData(uid: uid).then(
      (doc) {
        jobUser = JobUser.fromDocument(doc);
      },
    );
    return jobUser;
  }

  Future<void> setField(Map<String, dynamic> data) async {
    await _databaseService.setUserData(data: data, uid: uid);
  }
}
