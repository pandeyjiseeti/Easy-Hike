import 'package:easy_hike/models/job_model.dart';
import 'package:easy_hike/models/show_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../service_locator.dart';

class DescriptionExample extends StatefulWidget {
  Job description;
  DescriptionExample(this.description);
  @override
  _DescriptionExampleState createState() => _DescriptionExampleState();
}

class _DescriptionExampleState extends State<DescriptionExample> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ShowModel>(
      model: locator<ShowModel>(),
      child: Scaffold(
        bottomNavigationBar: Material(
          elevation: 15.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: ScopedModelDescendant<ShowModel>(
              builder: (context, child, ShowModel model) => FutureBuilder(
                future: model.hasApplied(
                    jobUID: widget.description.companyUid,
                    jobPosition: widget.description.jobPosition),
                builder: (context, snapshot) => MaterialButton(
                  height: MediaQuery.of(context).size.height * 0.06,
                  color: snapshot.data == true
                      ? Color(0xFFDF9A9A)
                      : Color(0xFFEA6161),
                  onPressed: () => snapshot.data == true
                      ? null
                      : model.applyForJob(
                          jobUID: widget.description.companyUid,
                          jobPosition: widget.description.jobPosition),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                  elevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  child: Text(
                    snapshot.data == true ? 'Applied' : 'Apply Now',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: ScopedModelDescendant<ShowModel>(
          builder: (context, child, ShowModel model) => ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15.0),
            children: [
              Center(
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.google,
                      size: 35.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      widget.description.company,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.description.location,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE5E9EE),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            widget.description.jobType,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          '₹${widget.description.salary}',
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Description(
                description:
                    widget.description.jobDescription['description'].toString(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Responsibilities(
                responsibilities: (widget.description
                        .jobDescription['responsibilities'] as List<dynamic>)
                    .map<String>((val) => val.toString())
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Qualifications(
                qualifications: (widget.description
                        .jobDescription['qualifications'] as List<dynamic>)
                    .map<String>((val) => val.toString())
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Job Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Remote Work Level'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget
                                  .description.otherDetails['remoteWorkLevel']
                                  .toString()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Date Posted'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.description.datePosted),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Job Type'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.description.jobType),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Job Schedule'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget
                                  .description.otherDetails['jobSchedule']
                                  .toString()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Career Level'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget
                                  .description.otherDetails['careerLevel']
                                  .toString()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Travel Required'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget
                                  .description.otherDetails['TravelRequired']
                                  .toString()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Categories'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget
                                  .description.otherDetails['Categories']
                                  .toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  final String description;
  const Description({
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("$description"),
        ],
      ),
    );
  }
}

class Responsibilities extends StatelessWidget {
  final List<String> responsibilities;
  const Responsibilities({
    @required this.responsibilities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Responsibilities',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in responsibilities)
                Text('${String.fromCharCode(0x2022)} $item\n'),
            ],
          ),
        ],
      ),
    );
  }
}

class Qualifications extends StatelessWidget {
  final List<String> qualifications;
  const Qualifications({
    @required this.qualifications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qualifications',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in qualifications)
                Text('${String.fromCharCode(0x2022)} $item\n'),
            ],
          ),
        ],
      ),
    );
  }
}
