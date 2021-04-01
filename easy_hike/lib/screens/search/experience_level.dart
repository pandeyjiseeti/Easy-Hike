import "package:flutter/material.dart";

class ExperienceLevel extends StatefulWidget {
  final List experienceLevels = [
    "Entry level",
    "Mid level",
    "Senior level",
    "Manager level",
    "Sr. Manager level",
  ];
  @override
  _ExperienceLevelState createState() => _ExperienceLevelState();
}

class _ExperienceLevelState extends State<ExperienceLevel> {
  int _value = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        5,
        (int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.35,
            margin: const EdgeInsets.only(right: 20.0),
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Radio(
                  activeColor: const Color(0xFFEA6161),
                  value: index,
                  groupValue: _value,
                  onChanged: (int selected) {
                    setState(() {
                      _value = selected;
                    });
                  },
                ),
                Expanded(
                  child: Text("${widget.experienceLevels[index]}"),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
