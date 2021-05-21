import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/screens/questions/personalintro.dart';
import 'package:easy_hike/screens/questions/question.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:easy_hike/screens/signup/signup.dart';
import 'package:easy_hike/widgets/or_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import 'login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<AuthModel>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 6),
                  width: screenWidth(context, dividedBy: 2),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("logo_dark.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 25),
                ),
                LoginForm(),
                const OrDivider(),
                SizedBox(
                  height: screenHeight(context, dividedBy: 40),
                ),
                ScopedModelDescendant<AuthModel>(
                  builder:
                      (BuildContext context, Widget child, AuthModel model) =>
                          SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () async {
                      final User user = await model.loginWithGoogle();
                      await checkProfileStatus(model, user, context);
                    },
                    text: "Log in with Google",
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 10),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 97, 97, 1)),
                        text: " Sign up ",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => SignUp(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future checkProfileStatus(
    AuthModel model, User user, BuildContext context) async {
  await model.getData(user.uid).then(
    (doc) async {
      if (doc.exists) {
        if (doc.data()['isProfileComplete'] == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MainSearch(),
              ),
              (route) => false);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => PersonalIntro(),
            ),
          );
        }
      } else {
        await model.addJobUser(user, user.displayName);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PersonalIntro(),
          ),
        );
      }
    },
  );
}
