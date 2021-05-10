import 'package:flutter/material.dart';
import 'homepage.dart';

class PersonalIntro extends StatefulWidget {
  @override
  _PersonalIntroState createState() => _PersonalIntroState();
}

class _PersonalIntroState extends State<PersonalIntro> {
  DateTime _dateTime = DateTime.now();
  var _name;
  var _email;
  var _phoneno;
  var _bday;
  var _paddress;
  var _raddress;

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
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            )
          },
        ),
        actions: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
              ),
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                child: Text("Personal Informations"),
                onPressed: () {
                  setState(() {});
                },
              ),
              TextField(
                controller: namecon,
                decoration: InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Name",
                    border: UnderlineInputBorder()),
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
                    border: UnderlineInputBorder()),
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
                    border: UnderlineInputBorder()),
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
                      hintText: _dateTime.toString(),
                      labelText: "Birthday",
                      focusedBorder: UnderlineInputBorder())),
              // Visibility(
              //     visible: _visible,
              //     child: Text('pick a date'),
              //     onPressed: ()  {
              //       showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(1950),
              //           lastDate: DateTime(2021));
              //     }),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: paddresscon,
                decoration: InputDecoration(
                    hintText: "Enter Permanent address",
                    labelText: "Permenant Address",
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: raddresscon,
                decoration: InputDecoration(
                    hintText: "Enter residential address",
                    labelText: "Residential Address",
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      setState(() {
                        _name = namecon.text;
                        _email = emailcon.text;
                        _phoneno = phonecon.text;
                        _bday = bdaycon.text;
                        _paddress = paddresscon.text;
                        _raddress = raddresscon.text;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
