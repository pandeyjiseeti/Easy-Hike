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

          ],
        ),
      ),
    );
  }
}
