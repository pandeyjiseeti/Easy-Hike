import 'package:easy_hike/config/pallete.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class CheckEmail extends StatefulWidget {
  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: 30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'email_check.png',
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 35),
            ),
            const Text(
              'Check your mail',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40.0),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
            const Text(
              'We have sent a password recover \ninstructions to your email.',
              style: TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
            MaterialButton(
              height: screenHeight(context, dividedBy: 15),
              minWidth: screenWidth(context, dividedBy: 2),
              color: primaryColor,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CheckEmail())),
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              child: const Text(
                'Open Email App',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Color.fromRGBO(234, 97, 97, 1), fontSize: 13.0),
                text: "Skip, I'll confirm later",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Login(),
                        ),
                      ),
              ),
            ),
            const Spacer(),
            const Text(
              'Did not receive the email? Check your spam filter, \nor try another email address',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 20),
            ),
          ],
        ),
      ),
    );
  }
}
