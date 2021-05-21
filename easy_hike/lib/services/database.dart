import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHelper {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser({User user, String fullName}) async {
    users
        .doc(user.uid)
        .set({
          "email": user.email,
          "fullName": fullName,
        })
        .then((value) => print("User Added ${user.displayName}"))
        .catchError((error) => print("Failed to add user: $error"));
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
