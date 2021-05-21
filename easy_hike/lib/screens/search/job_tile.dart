import 'package:easy_hike/screens/search/description.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobTile extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String salary;
  final String postTime;

  JobTile({
    this.jobTitle,
    this.company,
    this.location,
    this.salary,
    this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(17.0),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DescriptionExample(),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          border: Border.all(color: Colors.grey[300]),
        ),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FaIcon(FontAwesomeIcons.google),
          ),
          title: Text(
            '$jobTitle',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Text(
                "$company • $location",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "$salary",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Text(
            '$postTime Days',
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
