import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHelper {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser({User user, String fullName}) async {
    return users
        .add({
          "uid": user.uid,
          "email": user.email,
          "fullName": fullName,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
