import "package:flutter/material.dart";

class JobType extends StatefulWidget {
  final List jobTypes = [
    "Full-Time",
    "Part-Time",
    "Freelance",
    "Remote",
    "Internship",
    "Commission"
  ];
  @override
  _JobTypeState createState() => _JobTypeState();
}

class _JobTypeState extends State<JobType> {
  int _value = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        6,
        (int index) {
          return Container(
            margin: EdgeInsets.only(right: 15.0),
            child: ChoiceChip(
              labelStyle: TextStyle(
                  color: _value == index ? Colors.white : Colors.black),
              selectedColor: Color(0xFFEA6161),
              backgroundColor: Color(0xFFE5E9EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              label: Text('${widget.jobTypes[index]}'),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
