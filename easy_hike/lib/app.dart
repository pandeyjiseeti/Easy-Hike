import 'package:easy_hike/screens/questions/question.dart';
import 'package:easy_hike/screens/questions/work_experience.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:easy_hike/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login/login.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => Login(),
        '/work': (BuildContext context) => WorkExperience(),
        '/question': (BuildContext context) => Question(),
        '/search': (BuildContext context) => MainSearch(),
      },
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text(snapshot.error.toString())),
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
