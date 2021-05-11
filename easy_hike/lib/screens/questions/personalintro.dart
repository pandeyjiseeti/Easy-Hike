import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';

class PersonalIntro extends StatefulWidget {
  @override
  _PersonalIntroState createState() => _PersonalIntroState();
}

class _PersonalIntroState extends State<PersonalIntro> {
  DateTime _dateTime = DateTime.now();
  final namecon = new TextEditingController();
  final emailcon = new TextEditingController();
  final phonecon = new TextEditingController();
  final bdaycon = new TextEditingController();
  final paddresscon = new TextEditingController();
  final raddresscon = new TextEditingController();

  Future<Null> _selectdate(BuildContext context) async {
    DateTime _datepicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1940),
        lastDate: DateTime(2023),
        initialDatePickerMode: DatePickerMode.day,
        selectableDayPredicate: (DateTime val) =>
            val.weekday == 6 || val.weekday == 7 ? false : true);

    if (_datepicker != null && _datepicker != _dateTime) {
      setState(() {
        _dateTime = _datepicker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainSearch()),
            )
          },
        ),
        actions: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainSearch()),
              ),
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Form(
            child: Column(
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: namecon,
                  decoration: InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: emailcon,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Enter Email address",
                      labelText: "Email Address",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: phonecon,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "Enter phone number",
                      labelText: "Phone no",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: bdaycon,
                  readOnly: true,
                  onTap: () {
                    setState(() {
                      _selectdate(context);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Date Of Birth",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: paddresscon,
                  decoration: InputDecoration(
                      hintText: "Enter Permanent address",
                      labelText: "Permanent Address",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: raddresscon,
                  decoration: InputDecoration(
                      hintText: "Enter residential address",
                      labelText: "Residential Address",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          screenWidth(context) * 0.45,
                          screenHeight(context) * 0.06)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0),
                    ),
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
