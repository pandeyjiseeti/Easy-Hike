import 'package:easy_hike/config/pallete.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/screens/login/login.dart';
import 'package:easy_hike/screens/signup/signup.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("office_2.png"),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 90.0,
              height: screenHeight(context, dividedBy: 3.5),
              width: screenWidth(context, dividedBy: 1.5),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage("logo.png"),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                MaterialButton(
                  height: screenHeight(context, dividedBy: 14),
                  color: primaryColor,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SignUp(),
                    ),
                  ),
                  minWidth: screenWidth(context),
                  elevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 40),
                ),
                MaterialButton(
                  height: screenHeight(context, dividedBy: 14),
                  color: Colors.white,
                  shape: Border.all(color: primaryColor),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Login(),
                    ),
                  ),
                  elevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  minWidth: screenWidth(context),
                  child: Text(
                    'Log In',
                    style: TextStyle(color: primaryColor, fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
