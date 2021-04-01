import "package:flutter/material.dart";

import 'experience_level.dart';
import 'job_type.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      height: MediaQuery.of(context).size.height * 0.715,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          // RangeSlider(values: values, onChanged: () {}),
          // Text(
          //   "Job type",
          //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.02,
          // ),
          Text(
            "Job type",
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          JobType(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            "Experience Level",
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ExperienceLevel(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                height: MediaQuery.of(context).size.height * 0.06,
                color: const Color(0xFFEA6161),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minWidth: MediaQuery.of(context).size.width * 0.65,
                elevation: 0,
                hoverElevation: 0,
                highlightElevation: 0,
                child: const Text(
                  'Show Results',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Clear",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
