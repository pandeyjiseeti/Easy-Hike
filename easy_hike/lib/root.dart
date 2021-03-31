import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/screens/home.dart';
import 'package:easy_hike/screens/onboarding.dart';
import 'package:easy_hike/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().user,  //Auth Stream
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return OnBoarding();
          } else {
            return Home();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
