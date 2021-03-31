import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1.2,
          ),
        ),
        SizedBox(
          width: screenWidth(context, dividedBy: 50),
        ),
        const Text(
          "or",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          width: screenWidth(context, dividedBy: 50),
        ),
        const Expanded(
          child: Divider(
            thickness: 1.2,
          ),
        ),
      ],
    );
  }
}