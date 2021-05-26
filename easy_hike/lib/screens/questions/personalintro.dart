import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/models/question_model.dart';
import 'package:easy_hike/screens/questions/question.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../service_locator.dart';

class PersonalIntro extends StatefulWidget {
  @override
  _PersonalIntroState createState() => _PersonalIntroState();
}

class _PersonalIntroState extends State<PersonalIntro> {
  DateTime _dateTime;
  TextEditingController namecon;
  TextEditingController emailcon;
  TextEditingController phonecon;
  TextEditingController bdaycon;
  TextEditingController paddresscon;
  TextEditingController raddresscon;
  final DateFormat _dateFormatter = DateFormat('dd-MM-yyyy');
  Map<String, dynamic> _profileInformation;
  GlobalKey<FormState> _key;

  @override
  void initState() {
    _dateTime = DateTime.utc(2003, 5, 12);
    super.initState();
    namecon = TextEditingController();
    emailcon = TextEditingController();
    phonecon = TextEditingController();
    bdaycon = TextEditingController();
    paddresscon = TextEditingController();
    raddresscon = TextEditingController();
    _key = GlobalKey<FormState>();
  }

  Future<void> _selectdate(BuildContext context) async {
    final DateTime _datepicker = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1940),
      lastDate: DateTime(2003, 5, 12),
      initialDatePickerMode: DatePickerMode.day,
    );

    if (_datepicker != null) {
      _dateTime = _datepicker;
      bdaycon.text = _dateFormatter.format(_dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: locator<AuthModel>(),
      child: ScopedModelDescendant<AuthModel>(
        builder: (context, child, model) => WillPopScope(
          onWillPop: () async => buildAlertDialog(context, model),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () async => buildAlertDialog(context, model),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            color: Color.fromRGBO(234, 97, 97, 1),
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: namecon,
                          validator: MultiValidator(
                            [
                              MultiValidator(
                                [
                                  RequiredValidator(errorText: "* Required"),
                                  MinLengthValidator(4,
                                      errorText:
                                          "Name must be at least 4 characters long"),
                                  MaxLengthValidator(15,
                                      errorText:
                                          "Name should not be greater than 15 characters")
                                ],
                              ),
                            ],
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: emailcon,
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: '* Required'),
                              EmailValidator(
                                  errorText: 'Enter a valid email address'),
                            ],
                          ),
                          decoration: InputDecoration(
                              hintText: "Enter Email address",
                              labelText: "Email Address",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: phonecon,
                          keyboardType: TextInputType.phone,
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required'),
                            LengthRangeValidator(
                                min: 10,
                                max: 10,
                                errorText: 'Phone no. should be of 10 digits')
                          ]),
                          decoration: InputDecoration(
                              hintText: "Enter phone number",
                              labelText: "Phone number",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: bdaycon,
                          readOnly: true,
                          onTap: () => _selectdate(context),
                          validator: RequiredValidator(errorText: '* Required'),
                          decoration: InputDecoration(
                            labelText: "Date Of Birth",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: paddresscon,
                          maxLines: 2,
                          validator: RequiredValidator(errorText: '* Required'),
                          decoration: InputDecoration(
                              hintText: "Enter Permanent address",
                              labelText: "Permanent Address",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: raddresscon,
                          validator: RequiredValidator(errorText: '* Required'),
                          decoration: InputDecoration(
                              hintText: "Enter residential address",
                              labelText: "Residential Address",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ScopedModel<QuestionModel>(
                          model: locator<QuestionModel>(),
                          child: Padding(
                            padding: const EdgeInsets.all(45.0),
                            child: ScopedModelDescendant<QuestionModel>(
                              builder: (BuildContext context, Widget child,
                                      QuestionModel model) =>
                                  ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(
                                      screenWidth(context) * 0.65,
                                      screenHeight(context) * 0.06)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    model.profileInformation = {
                                      'fullName': namecon.text,
                                      'email': emailcon.text,
                                      'phoneNo': phonecon.text,
                                      'dob': bdaycon.text,
                                      'pAddress': paddresscon.text,
                                      'rAddress': raddresscon.text,
                                    };
                                    model.workExperience = [];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Question(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> buildAlertDialog(
  BuildContext context,
  AuthModel model,
) async {
  bool willPop;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Log Out'),
      content: Text('Do you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await model.signOut();
            willPop = true;
            Navigator.pop(context);
          },
          child: Text('YES'),
        ),
        TextButton(
          onPressed: () {
            willPop = false;
            Navigator.pop(context);
          },
          child: Text('NO'),
        ),
      ],
    ),
  );
  return willPop;
}
