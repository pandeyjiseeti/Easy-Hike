import 'package:flutter/material.dart';
import 'package:question_page/Pages/homepage.dart';
import 'personalintro.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var _description;
  var _position;
  var _company;
  var _industry;
  var _years;

  final descon = new TextEditingController();
  final poscon = new TextEditingController();
  final comcon = new TextEditingController();
  final indcon = new TextEditingController();
  final yearcon = new TextEditingController();

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
                    builder: (BuildContext context) => PersonalIntro()),
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
                child: Text("Job Description"),
                onPressed: () {},
              ),
              TextField(
                controller: poscon,
                decoration: InputDecoration(
                    hintText: "Current/Last job position",
                    labelText: "Job Position",
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: comcon,
                decoration: InputDecoration(
                    hintText: "Enter Company Name",
                    labelText: "Company Name",
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: indcon,
                decoration: InputDecoration(
                    hintText: "Enter Industry Name",
                    labelText: "Industry",
                    border: UnderlineInputBorder()),
              ),
              TextField(
                controller: yearcon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Years of Experience",
                    labelText: "Years",
                    border: UnderlineInputBorder()),
              ),
              TextField(
                controller: descon,
                decoration: InputDecoration(
                    hintText: "Enter descripion",
                    labelText: "Describe your job",
                    border: UnderlineInputBorder()),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      setState(() {
                        _position = poscon.text;
                        _description = descon.text;
                        _company = comcon.text;
                        _industry = indcon.text;
                        _years = yearcon.value;
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
