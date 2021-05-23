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
    return ScopedModel<AuthModel>(
      model: locator<AuthModel>(),
      child: ScopedModelDescendant<AuthModel>(
        builder: (context, child, model) => StreamBuilder(
          stream: model.user, //Auth Stream
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.uid == null) {
                return OnBoarding();
              } else {
                return FutureBuilder(
                  future: checkProfileCompletion(snapshot, model),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        print('hello ${snapshot.data}');
                        return MainSearch();
                      } else {
                        print('bye ${snapshot.data}');
                        return PersonalIntro();
                      }
                    } else {
                      return Scaffold(
                        body: Center(
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkProfileCompletion(
      AsyncSnapshot<User> snapshot, AuthModel model) async {
    bool isProfileComplete;
    await model.getData(snapshot.data.uid).then((value) async {
      if ((value.data() as Map<String, dynamic>)['isProfileComplete'] == null) {
        isProfileComplete = false;
        await model.setData(
            {'isProfileComplete': isProfileComplete}, snapshot.data.uid);
      } else if ((value.data() as Map<String, dynamic>)['isProfileComplete'] ==
          true) {
        print('TRue');
        isProfileComplete = true;
      }
    });
    return isProfileComplete;
  }
}
