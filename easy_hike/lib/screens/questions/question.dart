import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
// import 'package:question_page/Pages/homepage.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Current/Last job position",
                    labelText: "Job Position",
                    border: UnderlineInputBorder()),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Company Name",
                    labelText: "Company Name",
                    border: UnderlineInputBorder()),
              ),

              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Industry Name",
                    labelText: "Industry",
                    border: UnderlineInputBorder()),
              ),

              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Company Name",
                    labelText: "Company Name",
                    border: UnderlineInputBorder()),
              ),
          ],
        ),
    );
  }
}
