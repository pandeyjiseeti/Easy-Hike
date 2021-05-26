import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_hike/models/job_model.dart';
import 'package:easy_hike/models/show_model.dart';
import 'package:easy_hike/screens/search/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import '../service_locator.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Applications',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Text(
                  'APPLIED',
                  style: TextStyle(
                    color: Color.fromRGBO(234, 97, 97, 1),
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'HIRED',
                  style: TextStyle(
                    color: Color.fromRGBO(234, 97, 97, 1),
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'REJECTED',
                  style: TextStyle(
                    color: Color.fromRGBO(234, 97, 97, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          applicationPage('APPLIED'),
          applicationPage('HIRED'),
          applicationPage('REJECTED'),
        ]),
      ),
    );
  }
}

Widget applicationPage(String status) {
  return ScopedModel<ShowModel>(
    model: locator<ShowModel>(),
    child: ScopedModelDescendant<ShowModel>(
      builder: (context, child, ShowModel model) => FutureBuilder(
        future: model.getApplications(status),
        builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 15.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return JobTile(
                      company: snapshot.data[index].company,
                      location: snapshot.data[index].location,
                      jobTitle: snapshot.data[index].jobPosition,
                      salary: '\$${snapshot.data[index].salary}',
                      postTime: (DateTime.now().day -
                              DateFormat('yMMMMd')
                                  .parse(snapshot.data[index].datePosted
                                      .toString())
                                  .day)
                          .toString(),
                      description: snapshot.data[index],
                    );
                  },
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ),
  );
}
