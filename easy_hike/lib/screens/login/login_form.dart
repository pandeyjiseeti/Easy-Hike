import 'package:easy_hike/config/pallete.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/screens/login/login.dart';
import 'package:easy_hike/screens/questions/personalintro.dart';
import 'package:easy_hike/screens/questions/question.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import 'forgot_password.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _key;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _hidePassword;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _hidePassword = true;
  }

  void togglePassword() => setState(() => _hidePassword = !_hidePassword);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: EmailValidator(errorText: "Enter a valid email address"),
            style: const TextStyle(height: 0.5, fontSize: 14),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
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
            height: screenHeight(context, dividedBy: 45),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: MultiValidator(
              [
                RequiredValidator(errorText: "* Required"),
                MinLengthValidator(6,
                    errorText: "Password must be at least 6 characaters long"),
                MaxLengthValidator(15,
                    errorText:
                        "Password should not be greater than 15 characters")
              ],
            ),
            style: const TextStyle(height: 0.5, fontSize: 14),
            keyboardType: TextInputType.visiblePassword,
            obscureText: _hidePassword,
            controller: _passwordController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: FaIcon(_hidePassword
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye),
                  onPressed: () => togglePassword()),
              filled: true,
              fillColor: lightGrey,
              hintText: "Password",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightGrey),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context, dividedBy: 45),
          ),
          ScopedModelDescendant<AuthModel>(
            builder: (BuildContext context, Widget child, AuthModel model) =>
                MaterialButton(
              height: screenHeight(context, dividedBy: 15),
              color: primaryColor,
              onPressed: () async {
                if (_key.currentState.validate()) {
                  final User user = await model.login(
                      _emailController.text.trim(),
                      _passwordController.text.trim());
                  checkProfileStatus(model, user, context);
                }
              },
              minWidth: screenWidth(context),
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              child: const Text(
                'Log in',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context, dividedBy: 40),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Forgot Password?",
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ForgotPassword(),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: screenHeight(context, dividedBy: 25),
          ),
        ],
      ),
    );
  }
}
