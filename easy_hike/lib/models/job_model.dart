import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String jobPosition;
  String company;
  String location;
  String salary;
  String postTime;
  String companyLogo;
  String jobType;
  List<dynamic> jobDescription;

  Job(
      {this.jobPosition,
      this.company,
      this.location,
      this.salary,
      this.companyLogo,
      this.jobType,
      this.jobDescription});

  factory Job.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Job(
      jobPosition: docMap['jobPosition'].toString(),
      company: docMap['company'].toString(),
      location: docMap['location'].toString(),
      salary: docMap['salary'].toString(),
      companyLogo: docMap['companyLogo'].toString(),
      jobType: docMap['jobType'].toString(),
      jobDescription: docMap['jobDescription'] as List<dynamic>,
    );
  }
}
