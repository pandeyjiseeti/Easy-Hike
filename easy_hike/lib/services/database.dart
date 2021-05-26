import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/models/job_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHelper {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');
  CollectionReference applications =
      FirebaseFirestore.instance.collection('applications');

  List<Job> jobList;

  Future<void> addUser({User user, String fullName}) async {
    await users
        .doc(user.uid)
        .set({
          "email": user.email,
          "fullName": fullName,
          "uid": user.uid,
        })
        .then((value) => print("User Added ${user.displayName}"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<Job>> getAllCompanyJobs() async {
    jobList = [];
    await jobs.get().then((job) {
      for (var i in job.docs) {
        Job newJob = Job.fromDocument(i);
        // print(newJob.company);
        jobList.add(newJob);
      }
    });
    return jobList;
  }

  Future<void> applyForJob(
      {String uid, String jobUID, String jobPosition}) async {
    List<Map<String, dynamic>> candidates = [];
    await applications.doc(jobUID).get().then((value) {
      if (value.exists) {
        candidates = (value.data() as Map<String, dynamic>)['candidates']
            as List<Map<String, dynamic>>;
      }
    });
    candidates.add({'jobPosition': jobPosition, 'uid': uid});
    await applications.doc(jobUID).set({
      'candidates': candidates,
    }, SetOptions(merge: true));
  }

  Future<Job> getJob({String jobUID, String jobPosition}) async {
    Job job;
    await jobs
        .where('uid', isEqualTo: jobUID)
        .where('jobPosition', isEqualTo: jobPosition)
        .get()
        .then((value) {
      job = Job.fromDocument(value.docs[0]);
    });
    print('Job' + job.company);
    return job;
  }

  Future<List<QueryDocumentSnapshot>> getApplications({String uid}) async {
    List<QueryDocumentSnapshot> applicationList = [];
    await applications.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var i in value.docs) {
          if (((i.data() as Map<String, dynamic>)['candidates']
                  as List<dynamic>)
              .where((element) => element['uid'] == uid)
              .isNotEmpty) {
            applicationList.add(i);
          }
          // print(((applicationList[0].data() as Map<String, dynamic>)['candidates'] as List<dynamic>).where((element) => element['uid'] == uid).isNotEmpty);
        }
        // print(applicationList);
      }
    });
    return applicationList;
  }

  Future<bool> hasApplied(
      {String uid, String jobUID, String jobPosition}) async {
    bool isApplied = false;
    await applications.doc(jobUID).get().then((value) {
      if (value.exists) {
        isApplied = true;
        print(isApplied);
      }
    });
    return isApplied;
  }

  Future<void> setUserData({Map<String, dynamic> data, String uid}) async {
    await users.doc(uid).set(data, SetOptions(merge: true));
  }

  Future<void> updateUserData({Map<String, dynamic> data, String uid}) async {
    await users.doc(uid).update(data);
  }

  Future<DocumentSnapshot> getUserData({String uid}) async {
    return users.doc(uid).get();
  }
}
