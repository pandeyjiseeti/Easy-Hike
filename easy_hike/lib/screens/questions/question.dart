import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'personalintro.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String _description;
  String _position;
  String _company;
  String _industry;
  String _years;

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
            Navigator.pop(context),
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
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: comcon,
                decoration: InputDecoration(
                    hintText: "Enter Company Name",
                    labelText: "Company Name",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: indcon,
                decoration: InputDecoration(
                    hintText: "Enter Industry Name",
                    labelText: "Industry",
                    border: OutlineInputBorder()),
              ),
              TextField(
                controller: yearcon,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Years of Experience",
                    labelText: "Years",
                    border: OutlineInputBorder()),
              ),
              TextField(
                controller: descon,
                decoration: InputDecoration(
                    hintText: "Enter descripion",
                    labelText: "Describe your job",
                    border: OutlineInputBorder()),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _position = poscon.text;
                      _description = descon.text;
                      _company = comcon.text;
                      _industry = indcon.text;
                      _years = yearcon.text;
                    });
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
