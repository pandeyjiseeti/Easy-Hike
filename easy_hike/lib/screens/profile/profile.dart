import 'package:avatar_letter/avatar_letter.dart';
import 'package:easy_hike/config/screen_size_reducers.dart';
import 'package:easy_hike/models/profile_model.dart';
import 'package:easy_hike/models/user_model.dart';
import 'package:easy_hike/screens/questions/work_experience.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

import '../../service_locator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> globalKey;
  GlobalKey<FormState> globalKey2;
  GlobalKey<FormState> globalKey3;
  GlobalKey<FormState> globalKey4;
  TextEditingController textEditingController;
  TextEditingController textEditingController2;
  TextEditingController textEditingController3;
  TextEditingController textEditingController4;

  @override
  void initState() {
    globalKey2 = GlobalKey<FormState>();
    globalKey3 = GlobalKey<FormState>();
    globalKey = GlobalKey<FormState>();
    globalKey4 = GlobalKey<FormState>();
    textEditingController = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();
    textEditingController4 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Color.fromRGBO(234, 97, 97, 1),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: ScopedModel<ProfileModel>(
            model: locator<ProfileModel>(),
            child: ScopedModelDescendant<ProfileModel>(
              builder:
                  (BuildContext context, Widget child, ProfileModel model) =>
                      FutureBuilder(
                future: model.setData(),
                builder:
                    (BuildContext context, AsyncSnapshot<JobUser> jobSnapshot) {
                  if (jobSnapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Center(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    jobSnapshot.data.profileImage,
                                    width: 150.0,
                                    height: 150.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  jobSnapshot.data.fullName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 32.0),
                                  textAlign: TextAlign.center,
                                ),
                                jobSnapshot.data.role == 'null'
                                    ? Text('')
                                    : Text(
                                        jobSnapshot.data.role,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.center,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              socialMediaLinks('assets/linkedin.png',
                                  'https://www.linkedin.com/feed/'),
                              socialMediaLinks(
                                  'assets/github.png', 'https://github.com/'),
                              socialMediaLinks(
                                  'assets/twitter.png', 'https://twitter.com/'),
                              socialMediaLinks('assets/google-plus.png',
                                  'https://myaccount.google.com/intro/profile'),
                            ],
                          ),
                        ),
                        Text(
                          'Skills',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        if (jobSnapshot.data.skills.isNotEmpty)
                          SizedBox(
                            height: 100.0,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: jobSnapshot.data.skills
                                    .map<Widget>(
                                      (skill) => skillCard(
                                        skill.toString(),
                                      ),
                                    )
                                    .toList()),
                          )
                        else
                          Center(
                            child: Text('No Skills Present'),
                          ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(234, 97, 97, 1)),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                screenWidth(context) * 0.35,
                                screenHeight(context) * 0.035,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                String skill;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10.0),
                                  child: Form(
                                    key: globalKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: TextEditingController(
                                              text: skill),
                                          decoration: InputDecoration(
                                            hintText: "Enter Your Skill Name",
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onChanged: (val) => skill = val,
                                        ),
                                        const SizedBox(height: 10.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                            List<dynamic> skills =
                                                jobSnapshot.data.skills;
                                            skills.add(skill);
                                            await model.setField(
                                              {
                                                'skills': skills,
                                              },
                                            );
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        234, 97, 97, 1)),
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            minimumSize:
                                                MaterialStateProperty.all(
                                              Size(
                                                screenWidth(context) * 0.5,
                                                screenHeight(context) * 0.05,
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'ADD SKILL',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'ADD SKILLS',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(234, 97, 97, 1),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Experience',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: jobSnapshot.data.workExperience.isNotEmpty
                              ? jobSnapshot.data.workExperience
                                  .map(
                                    (workExperience) => TimelineTile(
                                      isFirst: jobSnapshot.data.workExperience
                                              .indexOf(workExperience) ==
                                          0,
                                      isLast: jobSnapshot.data.workExperience
                                              .indexOf(workExperience) ==
                                          jobSnapshot
                                                  .data.workExperience.length -
                                              1,
                                      endChild: WorkExperienceTile(
                                        company: workExperience['Company']
                                            .toString(),
                                        years: yearCalculate(
                                            workExperience['endDateYear']
                                                .toString(),
                                            workExperience['startDateYear']
                                                .toString()),
                                        position: workExperience['Position']
                                            .toString(),
                                        timeline: timelineCalculate(
                                            workExperience['endDateYear']
                                                .toString(),
                                            workExperience['startDateYear']
                                                .toString()),
                                        description:
                                            workExperience['Description']
                                                .toString(),
                                      ),
                                      beforeLineStyle: LineStyle(
                                          color: Colors.grey, thickness: 1.0),
                                      afterLineStyle: LineStyle(
                                          color: Colors.grey, thickness: 1.0),
                                      indicatorStyle: IndicatorStyle(
                                        width: 9.0,
                                        color: Colors.grey,
                                        padding: EdgeInsets.fromLTRB(
                                            4.0, 5.0, 4.0, 5.0),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [
                                  Center(
                                    child: Text('No Experience Present'),
                                  ),
                                ],
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(234, 97, 97, 1)),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                screenWidth(context) * 0.35,
                                screenHeight(context) * 0.035,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.pushNamed(context, '/question');
                            
                          },
                          child: Text(
                            'ADD EXPERIENCE',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(234, 97, 97, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Education',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: jobSnapshot.data.education.isNotEmpty
                              ? jobSnapshot.data.education
                                  .map((education) => educationTile(
                                      schoolName:
                                          education['schoolName'].toString(),
                                      course: education['course'].toString(),
                                      timePeriod:
                                          education['timePeriod'].toString()))
                                  .toList()
                              : [
                                  Center(
                                    child: Text('No Education Present'),
                                  ),
                                ],
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(234, 97, 97, 1)),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                screenWidth(context) * 0.35,
                                screenHeight(context) * 0.035,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                String school, course, timePeriod;
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10.0),
                                    child: Form(
                                      key: globalKey3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: TextEditingController(
                                                text: school),
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter Your School/Institution Name",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onChanged: (val) => school = val,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: TextEditingController(
                                                text: course),
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter Your Grade/Course/Program Name",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onChanged: (val) => course = val,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: TextEditingController(
                                                text: timePeriod),
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter your Time Period(Start Date - End Date)",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onChanged: (val) =>
                                                timePeriod = val,
                                          ),
                                          const SizedBox(height: 10.0),
                                          ElevatedButton(
                                            onPressed: () async {
                                              List<dynamic> education =
                                                  jobSnapshot.data.education;
                                              education.add({
                                                'schoolName': school,
                                                'course': course,
                                                'timePeriod': timePeriod,
                                              });
                                              await model.setField(
                                                {
                                                  'education': education,
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromRGBO(
                                                          234, 97, 97, 1)),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                Size(
                                                  screenWidth(context) * 0.5,
                                                  screenHeight(context) * 0.05,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'ADD EDUCATION',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'ADD EDUCATION',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(234, 97, 97, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Licenses & certifications',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: jobSnapshot.data.licenses.isNotEmpty
                              ? jobSnapshot.data.licenses
                                  .map(
                                    (license) => licensesTile(
                                      courseName:
                                          license['courseName'].toString(),
                                      courseSite:
                                          license['courseSite'].toString(),
                                      issuedData:
                                          license['issuedDate'].toString(),
                                      credentialId:
                                          license['credentialId'].toString(),
                                    ),
                                  )
                                  .toList()
                              : [
                                  Center(
                                    child: Text(
                                        'No Licenses & Certifications Present'),
                                  ),
                                ],
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(234, 97, 97, 1)),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                screenWidth(context) * 0.35,
                                screenHeight(context) * 0.035,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                String courseName,
                                    courseSite,
                                    issuedDate,
                                    credentialId;
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10.0),
                                    child: Form(
                                      key: globalKey4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              hintText: "Enter Course Name",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: textEditingController2,
                                            decoration: InputDecoration(
                                              hintText: "Enter Website Name",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: textEditingController3,
                                            decoration: InputDecoration(
                                              hintText: "Enter Issued Date",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onTap: () => _selectdate(context),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            controller: textEditingController4,
                                            decoration: InputDecoration(
                                              hintText: "Enter Credential Id",
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10.0),
                                          ElevatedButton(
                                            onPressed: () async {
                                              List<dynamic> licenses =
                                                  jobSnapshot.data.licenses;
                                              licenses.add({
                                                'courseName':
                                                    textEditingController.text,
                                                'courseSite':
                                                    textEditingController2.text,
                                                'issuedDate':
                                                    textEditingController3.text,
                                                'credentialId':
                                                    textEditingController4.text,
                                              });
                                              await model.setField(
                                                {
                                                  'licenses': licenses,
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromRGBO(
                                                          234, 97, 97, 1)),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                Size(
                                                  screenWidth(context) * 0.5,
                                                  screenHeight(context) * 0.05,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'ADD LICENSES & CERTS',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'ADD LICENSES & CERTS',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(234, 97, 97, 1),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded socialMediaLinks(String imagePath, String url) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.pink[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new IconButton(
            icon: Image(
              image: AssetImage(imagePath),
            ),
            onPressed: () => {
              launchURL(url),
            },
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  DateTime _dateTime = DateTime.utc(2003, 5, 12);

  final DateFormat _dateFormatter = DateFormat('dd-MM-yyyy');

  Future<void> _selectdate(BuildContext context) async {
    final DateTime _datepicker = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1940),
      lastDate: DateTime(2003, 5, 12),
      initialDatePickerMode: DatePickerMode.day,
    );

    if (_datepicker != null) {
      _dateTime = _datepicker;
      textEditingController3.text = _dateFormatter.format(_dateTime);
    }
  }

  Container skillCard(String skillName) {
    return Container(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      width: 100.0,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            AvatarLetter(
              size: 50,
              backgroundColor: RandomColor()
                  .randomColor(colorBrightness: ColorBrightness.dark),
              textColor: Colors.white,
              fontSize: 20,
              upperCase: true,
              letterType: LetterType.Circular,
              text: skillName,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              skillName,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget educationTile({String schoolName, String course, String timePeriod}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.school),
        title: Text(schoolName),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$course'),
              SizedBox(height: 5.0),
              Text('$timePeriod'),
            ],
          ),
        ),
      ),
    );
  }

  Widget licensesTile(
      {String courseName,
      String courseSite,
      String issuedData,
      String credentialId}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.code),
        title: Text(courseName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text('$courseSite'),
            SizedBox(height: 5.0),
            Text('$issuedData'),
            SizedBox(height: 5.0),
            Text('$credentialId'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
