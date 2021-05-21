import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class JobUser {
  final String uid;
  final String fullName;
  final String email;
  final int phoneNo;
  final String dob;
  final String pAddress;
  final String rAddress;
  final List<Map<String, dynamic>> workExperience;

  JobUser({
    this.workExperience,
    this.uid,
    this.fullName,
    this.email,
    this.phoneNo,
    this.dob,
    this.pAddress,
    this.rAddress,
  });

  factory JobUser.fromDocument(DocumentSnapshot doc) {
    return JobUser(
      uid: doc['uid'].toString(),
      fullName: doc['fullName'].toString(),
      email: doc['email'].toString(),
      phoneNo: int.parse(['phoneNo'].toString()),
      dob: doc['dob'].toString(),
      pAddress: doc['pAddress'].toString(),
      rAddress: doc['rAddress'].toString(),
      // workExperience: doc['workExperience'],
    );
  }
}

class JobUserModel extends Model {}
