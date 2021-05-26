import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/profile_model.dart';
import 'package:easy_hike/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart';
import '../../service_locator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  ImagePicker picker;
  String image;
  File _imageFile;
  ProgressDialog pd;

  @override
  void initState() {
    picker = ImagePicker();
    _dateTime = DateTime.utc(2003, 5, 12);
    namecon = TextEditingController();
    emailcon = TextEditingController();
    phonecon = TextEditingController();
    bdaycon = TextEditingController();
    paddresscon = TextEditingController();
    raddresscon = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  Future<String> initPage() async {
    final String uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      final JobUser jobUser = JobUser.fromDocument(value);
      namecon.text = jobUser.fullName;
      emailcon.text = jobUser.email;
      phonecon.text = jobUser.phoneNo;
      bdaycon.text = jobUser.dob;
      paddresscon.text = jobUser.pAddress;
      raddresscon.text = jobUser.rAddress;
      image = jobUser.profileImage;
    });
    return 'Future Complete';
  }

  Future<void> uploadFile(String filePath, BuildContext context) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/${basename(filePath)}')
          .putFile(_imageFile);
      image = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/${basename(filePath)}')
          .getDownloadURL();
      setState(() {});
      print(image);
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
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
    pd = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pd.style(message: "Uploading Image");
    return WillPopScope(
      onWillPop: () async => buildAlertDialog(context),
      child: FutureBuilder(
        future: initPage(),
        builder: (context, snapshot) => ScopedModel<ProfileModel>(
          model: locator<ProfileModel>(),
          child: ScopedModelDescendant<ProfileModel>(
            builder: (BuildContext context, Widget child, ProfileModel model) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: true,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () async {
                          await buildAlertDialog(context);
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              await model.setField(
                                {
                                  'fullName': namecon.text,
                                  'phoneNo': phonecon.text,
                                  'dob': bdaycon.text,
                                  'pAddress': paddresscon.text,
                                  'rAddress': raddresscon.text,
                                  'profileImage': image,
                                },
                              );
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: SizedBox(
                            width: screenWidth(context),
                            child: Form(
                              key: _key,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await pickImage();
                                      pd.show();
                                      await uploadFile(
                                          _imageFile.path, context);
                                      pd.hide();
                                      print(image);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(image),
                                    ),
                                  ),
                                  SizedBox(height: 40.0),
                                  TextFormField(
                                    controller: namecon,
                                    validator: MultiValidator(
                                      [
                                        MultiValidator(
                                          [
                                            RequiredValidator(
                                                errorText: "* Required"),
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
                                        border: OutlineInputBorder()),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: emailcon,
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: phonecon,
                                    keyboardType: TextInputType.phone,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: '* Required'),
                                      LengthRangeValidator(
                                          min: 10,
                                          max: 10,
                                          errorText:
                                              'Phone no. should be of 10 digits')
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
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
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
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
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
                                    validator: RequiredValidator(
                                        errorText: '* Required'),
                                    decoration: InputDecoration(
                                        hintText: "Enter residential address",
                                        labelText: "Residential Address",
                                        border: OutlineInputBorder()),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<bool> buildAlertDialog(
  BuildContext context,
) async {
  bool willPop;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Discard Changes'),
      content: Text('Do you want to discard the changes?'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
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
