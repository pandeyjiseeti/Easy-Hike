import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/auth_model.dart';
import 'package:easy_hike/models/question_model.dart';
import 'package:easy_hike/screens/questions/question.dart';
import 'package:easy_hike/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../service_locator.dart';

class WorkExperience extends StatefulWidget {
  @override
  _WorkExperienceState createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  String uid;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<QuestionModel>(
      model: locator<QuestionModel>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    screenWidth(context) * 0.7,
                    screenHeight(context) * 0.06,
                  ),
                ),
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/question');
                setState(() {});
              },
              child: Text(
                'ADD MORE EXPERIENCE',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
            child: ScopedModelDescendant<QuestionModel>(
              builder:
                  (BuildContext context, Widget child, QuestionModel model) =>
                      ScopedModel<AuthModel>(
                model: locator<AuthModel>(),
                child: ScopedModelDescendant<AuthModel>(
                  builder: (BuildContext context, Widget child,
                          AuthModel authModel) =>
                      ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          screenWidth(context) * 0.7,
                          screenHeight(context) * 0.06,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      model.profileInformation.addAll(
                        {'isProfileComplete': true},
                      );
                      uid = (await authModel.user.take(1).toList())[0]
                          .uid
                          .toString();
                      print('Outside Stream $uid');
                      await model.setData(uid);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MainSearch()),
                          (route) => false);
                    },
                    child: Text(
                      'Done!',
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: ScopedModelDescendant<QuestionModel>(
            builder:
                (BuildContext context, Widget child, QuestionModel model) =>
                    SizedBox(
              height:
                  screenHeight(context) - Scaffold.of(context).appBarMaxHeight,
              child: Column(
                children: [
                  Text(
                    "Work Experience",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          WorkExperienceTile(
                        company:
                            model.workExperience[index]['Company'].toString(),
                        years: yearCalculate(
                            model.workExperience[index]['endDateYear']
                                .toString(),
                            model.workExperience[index]['startDateYear']
                                .toString()),
                        position:
                            model.workExperience[index]['Position'].toString(),
                        timeline: timelineCalculate(
                            model.workExperience[index]['endDateYear']
                                .toString(),
                            model.workExperience[index]['startDateYear']
                                .toString()),
                        description: model.workExperience[index]['Description']
                            .toString(),
                      ),
                      itemCount: model.workExperience.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 30.0,
                        thickness: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String timelineCalculate(String endDateYear, String startDateYear) {
  if (endDateYear == '0') {
    return "$startDateYear-present";
  }
  return "$startDateYear-$endDateYear";
}

String yearCalculate(String endDateYear, String startDateYear) {
  final int startYear = int.parse(startDateYear);
  if (endDateYear == '0') {
    return (DateTime.now().year - startYear).toString();
  }
  return (int.parse(endDateYear) - startYear).toString();
}

class WorkExperienceTile extends StatelessWidget {
  final String years;
  final String position;
  final String timeline;
  final String company;
  final String description;

  WorkExperienceTile(
      {this.years,
      this.position,
      this.timeline,
      this.company,
      this.description});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 35.0,
      leading: Column(
        children: [
          Text(
            years,
            style: TextStyle(
              fontSize: 35.0,
            ),
          ),
          Text(
            'YEARS',
            style: TextStyle(color: Colors.grey[400], fontSize: 11.0),
          ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              position.toUpperCase(),
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Text(
            timeline,
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      isThreeLine: true,
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              company,
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 10.0),
            Text(description),
          ],
        ),
      ),
    );
  }
}
