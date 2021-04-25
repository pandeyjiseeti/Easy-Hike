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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            // )
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
