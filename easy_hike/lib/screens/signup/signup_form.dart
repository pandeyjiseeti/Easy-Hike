import 'package:easy_hike/config/pallete.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';
import '../home.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _fullNameController;
  GlobalKey<FormState> _key;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _hidePassword;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
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
            validator: MultiValidator(
              [
                RequiredValidator(errorText: "* Required"),
                MinLengthValidator(4,
                    errorText: "Name must be at least 4 characters long"),
                MaxLengthValidator(15,
                    errorText: "Name should not be greater than 15 characters")
              ],
            ),
            style: const TextStyle(height: 0.5, fontSize: 14),
            keyboardType: TextInputType.name,
            controller: _fullNameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightGrey,
              hintText: "Full Name",
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
                    errorText: "Password must be at least 6 digits long"),
                MaxLengthValidator(15,
                    errorText:
                        "Password should not be greater than 15 characters")
              ],
            ),
            style: const TextStyle(height: 0.5, fontSize: 14),
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: _hidePassword,
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
                await model.createAccount(_emailController.text.trim(),
                    _passwordController.text.trim());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainSearch(),
                  ),
                );
              },
              minWidth: screenWidth(context),
              elevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
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
