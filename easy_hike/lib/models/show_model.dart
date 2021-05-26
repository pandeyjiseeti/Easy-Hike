import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/models/job_model.dart';
import 'package:easy_hike/services/auth.dart';
import 'package:easy_hike/services/database.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ShowModel extends Model {
  final Auth _authService = locator<Auth>();
  final DatabaseHelper _databaseService = locator<DatabaseHelper>();

  Future<String> getUID() async =>
      (await _authService.user.take(1).toList())[0].uid;

  Future<List<Job>> listJobs() async {
    return _databaseService.getAllCompanyJobs();
  }

  Future<List<Job>> getApplications(String status) async {
    final String uid = await getUID();
    List<QueryDocumentSnapshot> allCompany = [];
    allCompany = await _databaseService.getApplications(uid: uid);
    List<Job> allApplications = [];
    for (var i in allCompany) {
      for (var j in (i.data() as Map<String, dynamic>)['candidates']
          as List<dynamic>) {
        if (j['status'] == status) {
          Job job = await getJob(
              jobUID: i.id, jobPosition: j['jobPosition'].toString());
          allApplications.add(job);
        }
      }
    }
    // print(allApplications);
    return allApplications;
  }

  Future<Job> getJob({String jobUID, String jobPosition}) async {
    return _databaseService.getJob(jobUID: jobUID, jobPosition: jobPosition);
  }

  Future<void> hasApplied({String jobUID, String jobPosition}) async {
    final String uid = await getUID();
    bool applied = await _databaseService.hasApplied(
        uid: uid, jobUID: jobUID, jobPosition: jobPosition);
    return applied;
  }

  Future<void> applyForJob({String jobUID, String jobPosition}) async {
    final String uid = await getUID();
    await _databaseService.applyForJob(
        uid: uid, jobUID: jobUID, jobPosition: jobPosition);
    notifyListeners();
  }
}
