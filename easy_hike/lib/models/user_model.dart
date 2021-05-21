import 'package:cloud_firestore/cloud_firestore.dart';

class JobUser {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String dob;
  final String pAddress;
  final String rAddress;
  final String role;
  final List<dynamic> workExperience;
  final String profileImage;
  final List<dynamic> skills;
  final List<dynamic> education;
  final List<dynamic> licenses;

  JobUser({
    this.workExperience,
    this.uid,
    this.fullName,
    this.email,
    this.phoneNo,
    this.dob,
    this.pAddress,
    this.rAddress,
    this.profileImage,
    this.role,
    this.skills,
    this.education,
    this.licenses,
  });

  factory JobUser.fromDocument(DocumentSnapshot doc) {
    return JobUser(
      uid: doc.data()['uid'].toString(),
      fullName: doc.data()['fullName'].toString(),
      email: doc.data()['email'].toString(),
      phoneNo: doc.data()['phoneNo'].toString(),
      dob: doc.data()['dob'].toString(),
      pAddress: doc.data()['pAddress'].toString(),
      rAddress: doc.data()['rAddress'].toString(),
      profileImage: doc.data()['profileImage'].toString(),
      role: doc.data()['role'].toString(),
      workExperience: doc.data()['WorkExperience'] as List<dynamic> ?? [],
      skills: (doc.data()['skills'] as List<dynamic>) ?? [],
      education: (doc.data()['education'] as List<dynamic>) ?? [],
      licenses: (doc.data()['licenses'] as List<dynamic>) ?? [],
    );
  }
}
