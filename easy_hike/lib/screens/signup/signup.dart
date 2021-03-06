import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/screens/login/login.dart';
import 'package:easy_hike/screens/questions/personalintro.dart';
import 'package:easy_hike/screens/questions/question.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:easy_hike/widgets/or_divider.dart';
import 'package:easy_hike/widgets/policy_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import 'signup_form.dart';

class SignUp extends StatelessWidget {
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
                SignUpForm(),
                const OrDivider(),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                ScopedModelDescendant<AuthModel>(
                  builder:
                      (BuildContext context, Widget child, AuthModel model) =>
                          SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () async {
                      final User user = await model.loginWithGoogle();
                      await model.addJobUser(user, user.displayName);
                      print(user.displayName);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PersonalIntro(),
                        ),
                      );
                    },
                    elevation: 0,
                    text: "Sign up with Google",
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 60),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By signing up you accept the",
                    style: const TextStyle(color: Colors.grey, fontSize: 11.0),
                    children: [
                      TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 97, 97, 1)),
                        text: " Terms of Service ",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showDialog(
                                context: context,
                                builder: (BuildContext context) => PolicyDialog(
                                  mdFileName: 'terms_of_use.md',
                                ),
                              ),
                      ),
                      const TextSpan(
                        text: "and",
                      ),
                      TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 97, 97, 1)),
                        text: " Privacy Policy",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showDialog(
                                context: context,
                                builder: (BuildContext context) => PolicyDialog(
                                  mdFileName: 'privacy_policy.md',
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 20),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account?",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 97, 97, 1)),
                        text: " Log in ",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Login(),
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
