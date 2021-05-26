import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String companyUid;
  String jobPosition;
  String company;
  String location;
  String salary;
  String datePosted;
  String companyLogo;
  String jobType;
  Map<String, dynamic> jobDescription;
  Map<String, dynamic> otherDetails;

  Job(
      {this.companyUid,
      this.jobPosition,
      this.company,
      this.location,
      this.salary,
      this.companyLogo,
      this.jobType,
      this.jobDescription,
      this.datePosted,
      this.otherDetails});

  factory Job.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Job(
        companyUid: docMap['uid'].toString(),
        jobPosition: docMap['jobPosition'].toString(),
        company: docMap['company'].toString(),
        location: docMap['location'].toString(),
        salary: docMap['salary'].toString(),
        companyLogo: docMap['companyLogo'].toString(),
        jobType: docMap['jobType'].toString(),
        jobDescription: docMap['jobDescription'] as Map<String, dynamic>,
        datePosted: docMap['datePosted'].toString(),
        otherDetails: docMap['otherDetails'] as Map<String, dynamic>);
  }
}
