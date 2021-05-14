import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/screens/onboarding.dart';
import 'package:easy_hike/screens/questions/personalintro.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:easy_hike/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/auth_model.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _isProfileComplete = false;
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<AuthModel>(),
      child: ScopedModelDescendant<AuthModel>(
        builder: (context, child, model) => StreamBuilder(
          stream: model.user, //Auth Stream
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.uid == null) {
                return OnBoarding();
              } else {
                checkProfileCompletion(snapshot);
                if (_isProfileComplete) {
                  return MainSearch();
                }
                return PersonalIntro();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<void> checkProfileCompletion(AsyncSnapshot<User> snapshot) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: snapshot.data.uid)
        .get()
        .then((value) async {
      if (value.docs[0].data()['isProfileComplete'] == null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.docs[0].id)
            .update({
          'isProfileComplete': _isProfileComplete,
        });
      } else if (value.docs[0].data()['isProfileComplete'] == true) {
        _isProfileComplete = true;
      }
    });
  }
}
