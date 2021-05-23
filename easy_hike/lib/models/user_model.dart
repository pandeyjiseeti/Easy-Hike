import 'package:cloud_firestore/cloud_firestore.dart';

class JobUser {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String dob;
  final String pAddress;
  final String rAddress;

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
    this.skills,
    this.education,
    this.licenses,
  });

  factory JobUser.fromDocument(DocumentSnapshot doc) {
    return JobUser(
      uid: (doc.data() as Map<String, dynamic>)['uid'].toString(),
      fullName: (doc.data() as Map<String, dynamic>)['fullName'].toString(),
      email: (doc.data() as Map<String, dynamic>)['email'].toString(),
      phoneNo: (doc.data() as Map<String, dynamic>)['phoneNo'].toString(),
      dob: (doc.data() as Map<String, dynamic>)['dob'].toString(),
      pAddress: (doc.data() as Map<String, dynamic>)['pAddress'].toString(),
      rAddress: (doc.data() as Map<String, dynamic>)['rAddress'].toString(),
      profileImage:
          (doc.data() as Map<String, dynamic>)['profileImage'].toString(),
      workExperience: (doc.data() as Map<String, dynamic>)['WorkExperience']
              as List<dynamic> ??
          [],
      skills:
          ((doc.data() as Map<String, dynamic>)['skills'] as List<dynamic>) ??
              [],
      education: ((doc.data() as Map<String, dynamic>)['education']
              as List<dynamic>) ??
          [],
      licenses:
          ((doc.data() as Map<String, dynamic>)['licenses'] as List<dynamic>) ??
              [],
    );
  }
}
