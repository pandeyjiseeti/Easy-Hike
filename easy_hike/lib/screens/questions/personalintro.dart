import 'package:flutter/material.dart';

class PersonalIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton(
              child: Text("Personal Informations"),
              onPressed: () {
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
