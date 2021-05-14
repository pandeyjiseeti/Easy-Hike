import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'personalintro.dart';

class Question extends StatefulWidget {
  Map<String, dynamic> profileInformation;
  Question(this.profileInformation);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController descon;
  TextEditingController poscon;
  TextEditingController comcon;
  TextEditingController indcon;
  TextEditingController yearcon;

  @override
  void initState() {
    super.initState();
    descon = new TextEditingController();
    poscon = new TextEditingController();
    comcon = new TextEditingController();
    indcon = new TextEditingController();
    yearcon = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  Size(screenWidth(context), screenHeight(context) * 0.07)),
            ),
            onPressed: () {
              widget.profileInformation.addAll({
                "Position": poscon.text,
                "Description": descon.text,
                "Company": comcon.text,
                "Industry": indcon.text,
                "Year": yearcon.text,
              });
            },
            child: Text(
              'ADD EXPERIENCE',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        )
      ],
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
              'SKIP',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            children: [
              Text(
                "Work Experience",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 40.0),
              ListTileTheme(
                  tileColor: Colors.grey[100],
                  child: ExpansionTile(
                      title: Text('Job Description',
                          style: TextStyle(fontWeight: FontWeight.w500)))),
              SizedBox(
                height: 16,
              ),
              ListTileTheme(
                  tileColor: Colors.grey[100],
                  child: ExpansionTile(
                      title: Text('Years of Experience',
                          style: TextStyle(fontWeight: FontWeight.w500)))),
              SizedBox(
                height: 16,
              ),
              ListTileTheme(
                  tileColor: Colors.grey[100],
                  child: ExpansionTile(
                      title: Text('Description',
                          style: TextStyle(fontWeight: FontWeight.w500)))),
              SizedBox(
                height: 16,
              ),
              // TextField(
              //   controller: yearcon,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //       hintText: "Years of Experience",
              //       labelText: "Years",
              //       border: OutlineInputBorder()),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // TextField(
              //   controller: descon,
              //   decoration: InputDecoration(
              //       hintText: "Enter descripion",
              //       labelText: "Describe your job",
              //       border: OutlineInputBorder()),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
