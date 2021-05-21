import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/question_model.dart';
import 'package:easy_hike/screens/questions/work_experience.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../service_locator.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String jobPosition, company, industry, description;
  String startDateMonth, startDateYear, endDateMonth, endDateYear;
  bool hasWorkExperience, isWorking;
  GlobalKey<FormState> _key;
  TextEditingController textEditingController2,
      textEditingController,
      textEditingController3,
      textEditingController4,
      textEditingController5,
      textEditingController6,
      textEditingController7,
      textEditingController8;

  @override
  void initState() {
    super.initState();
    hasWorkExperience = true;
    isWorking = false;
    _key = GlobalKey<FormState>();
    textEditingController2 = TextEditingController(text: company);
    textEditingController = TextEditingController(text: jobPosition);
    textEditingController3 = TextEditingController(text: industry);
    textEditingController4 = TextEditingController(text: startDateMonth);
    textEditingController5 = TextEditingController(text: startDateYear);
    textEditingController6 = TextEditingController(text: endDateMonth);
    textEditingController7 = TextEditingController(text: endDateYear);
    textEditingController8 = TextEditingController(text: description);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<QuestionModel>(
      model: locator<QuestionModel>(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          persistentFooterButtons: [
            ScopedModelDescendant<QuestionModel>(
              builder:
                  (BuildContext context, Widget child, QuestionModel model) =>
                      Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: hasWorkExperience
                    ? ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              screenWidth(context),
                              screenHeight(context) * 0.07,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            model.workExperience.add(
                              {
                                'Position': jobPosition,
                                'Company': company,
                                'Industry': industry,
                                'Description': description,
                                'startDateMonth': int.parse(startDateMonth),
                                'startDateYear': int.parse(startDateYear),
                                'endDateMonth':
                                    isWorking ? 0 : int.parse(endDateMonth),
                                'endDateYear':
                                    isWorking ? 0 : int.parse(endDateYear),
                                'isWorking': isWorking,
                              },
                            );
                            model.profileInformation.addAll(
                              {
                                'isProfileComplete': true,
                                'hasWorkExperience': hasWorkExperience,
                                'WorkExperience': model.workExperience,
                              },
                            );
                            print(model.profileInformation.toString());
                            if (model.workExperience.length > 1) {
                              Navigator.pop(context, "Update");
                            } else {
                              Navigator.popAndPushNamed(context, '/work');
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Check all the fields and Enter appropriate Information.'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'ADD EXPERIENCE',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(
                              screenWidth(context),
                              screenHeight(context) * 0.07)),
                        ),
                        onPressed: () async {
                          model.profileInformation.addAll(
                            {
                              'isProfileComplete': true,
                              'hasWorkExperience': model.profileInformation[
                                      'hasWorkExperience'] ??
                                  hasWorkExperience,
                              'WorkExperience': model.workExperience,
                            },
                          );
                          Navigator.popAndPushNamed(context, '/work');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkExperience(),
                            ),
                          );
                        },
                        child: Text(
                          'Done!',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
              ),
            ),
          ],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                children: [
                  Text(
                    "Work Experience",
                    style: TextStyle(
                      color: Color.fromRGBO(234, 97, 97, 1),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ScopedModelDescendant<QuestionModel>(
                    builder: (BuildContext context, Widget child,
                            QuestionModel model) =>
                        Visibility(
                      visible: model.workExperience.isEmpty,
                      child: SwitchListTile(
                        tileColor: Colors.white,
                        title: Text("I have Work Experience"),
                        value: hasWorkExperience,
                        onChanged: (val) => setState(
                          () => hasWorkExperience = val,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AbsorbPointer(
                    absorbing: !hasWorkExperience,
                    child: Opacity(
                      opacity: hasWorkExperience ? 1.0 : 0.5,
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            ListTileTheme(
                              tileColor: Colors.grey[100],
                              child: ExpansionTile(
                                maintainState: true,
                                title: Text(
                                  'Job Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                childrenPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 20.0,
                                ),
                                children: [
                                  TextFormField(
                                    controller: textEditingController,
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(234, 97, 97, 1),
                                        fontSize: 18.0,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: "JOB POSITION",
                                      hintText: "Enter Job Position",
                                      hintStyle: TextStyle(height: 2.0),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged: (value) => jobPosition = value,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: textEditingController2,
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(234, 97, 97, 1),
                                        fontSize: 18.0,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: "COMPANY NAME",
                                      hintText: "Enter Company Name",
                                      hintStyle: TextStyle(height: 2.0),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged: (value) => company = value,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: textEditingController3,
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Color.fromRGBO(234, 97, 97, 1),
                                        fontSize: 18.0,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: "INDUSTRY",
                                      hintText: "Enter Industry",
                                      hintStyle: TextStyle(height: 2.0),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged: (value) => industry = value,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ListTileTheme(
                              tileColor: Colors.grey[100],
                              child: ExpansionTile(
                                maintainState: true,
                                title: Text(
                                  'Years of Experience',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                      vertical: 20.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "START DATE",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    234, 97, 97, 1),
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.05,
                                              width:
                                                  screenWidth(context) * 0.25,
                                              child: TextFormField(
                                                  controller:
                                                      textEditingController4,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                          errorText:
                                                              '* Required'),
                                                      RangeValidator(
                                                        min: 1,
                                                        max: 12,
                                                        errorText:
                                                            "Invalid Month",
                                                      ),
                                                    ],
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "Month",
                                                  ),
                                                  onChanged: (value) =>
                                                      startDateMonth = value),
                                            ),
                                            SizedBox(
                                              height:
                                                  screenHeight(context) * 0.05,
                                              width:
                                                  screenWidth(context) * 0.25,
                                              child: TextFormField(
                                                controller:
                                                    textEditingController5,
                                                validator: MultiValidator(
                                                  [
                                                    RequiredValidator(
                                                        errorText:
                                                            '* Required'),
                                                    RangeValidator(
                                                      min: 1947,
                                                      max: 2021,
                                                      errorText: "Invalid Year",
                                                    ),
                                                  ],
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Year",
                                                ),
                                                onChanged: (value) =>
                                                    startDateYear = value,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Opacity(
                                          opacity: isWorking ? 0.5 : 1.0,
                                          child: AbsorbPointer(
                                            absorbing: isWorking,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "LAST DATE",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        234, 97, 97, 1),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenHeight(context) *
                                                          0.05,
                                                  width: screenWidth(context) *
                                                      0.25,
                                                  child: TextFormField(
                                                    controller:
                                                        textEditingController6,
                                                    validator: isWorking
                                                        ? null
                                                        : MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                  errorText:
                                                                      '* Required'),
                                                              RangeValidator(
                                                                min: 1,
                                                                max: 12,
                                                                errorText:
                                                                    "Invalid Month",
                                                              ),
                                                            ],
                                                          ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText: "Month",
                                                    ),
                                                    onChanged: (value) =>
                                                        endDateMonth = value,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenHeight(context) *
                                                          0.05,
                                                  width: screenWidth(context) *
                                                      0.25,
                                                  child: TextFormField(
                                                      controller:
                                                          textEditingController7,
                                                      validator: isWorking
                                                          ? null
                                                          : MultiValidator(
                                                              [
                                                                RequiredValidator(
                                                                    errorText:
                                                                        '* Required'),
                                                                RangeValidator(
                                                                  min: 1947,
                                                                  max: 2021,
                                                                  errorText:
                                                                      "Invalid Year",
                                                                ),
                                                              ],
                                                            ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Year",
                                                      ),
                                                      onChanged: (value) =>
                                                          endDateYear = value),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SwitchListTile(
                                    tileColor: Colors.white,
                                    title: Text("I'm currently working here"),
                                    value: isWorking,
                                    onChanged: (val) => setState(
                                      () => isWorking = val,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ListTileTheme(
                              tileColor: Colors.grey[100],
                              child: ExpansionTile(
                                maintainState: true,
                                title: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 20.0),
                                    child: TextFormField(
                                      controller: textEditingController8,
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                              errorText: '* Required'),
                                          MinLengthValidator(150,
                                              errorText:
                                                  "Description should have minimum of 150 chars")
                                        ],
                                      ),
                                      maxLines: 6,
                                      maxLength: 500,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                          color: Color.fromRGBO(234, 97, 97, 1),
                                          fontSize: 18.0,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: "Description",
                                        hintText: "Enter Job Description",
                                        hintStyle: TextStyle(),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) => description = value,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
