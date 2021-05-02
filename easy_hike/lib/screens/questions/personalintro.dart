import 'package:flutter/material.dart';
import 'homepage.dart';

class PersonalIntro extends StatefulWidget {
  @override
  _PersonalIntroState createState() => _PersonalIntroState();
}

class _PersonalIntroState extends State<PersonalIntro> {
  bool _visible = false;
  bool _visible2 = false;
  DateTime _dateTime;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton(
              child: Text("Personal Informations"),
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                  border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Email address",
                  labelText: "Email Address",
                  border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter phone number",
                  labelText: "Phone no",
                  border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
                visible: _visible,
                child: Text('pick a date'),
                onpressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2021));
                }),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Permanent address",
                  labelText: "Permenant Address",
                  border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter residential address",
                  labelText: "Residential Address",
                  border: UnderlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter residential address",
                  labelText: "Residential Address",
                  border: UnderlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}
