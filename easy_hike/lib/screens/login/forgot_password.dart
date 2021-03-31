import 'package:easy_hike/config/pallete.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'check_email.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: 30),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 40),
            ),
            const Text('Reset Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40.0)),
            SizedBox(
              height: screenHeight(context, dividedBy: 35),
            ),
            const Text(
                "Enter the email associated with your account and we'll send an email with instructions to reset your password."),
            SizedBox(
              height: screenHeight(context, dividedBy: 25),
            ),
            TextFormField(
              style: const TextStyle(height: 0.5, fontSize: 14),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: EmailValidator(errorText: "Enter a valid email address"),
              decoration: InputDecoration(
                filled: true,
                fillColor: lightGrey,
                hintText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lightGrey),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 35),
            ),
            MaterialButton(
              height: screenHeight(context, dividedBy: 15),
              color: primaryColor,
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CheckEmail())),
              minWidth: screenWidth(context),
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              child: const Text(
                'Send Instructions',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
