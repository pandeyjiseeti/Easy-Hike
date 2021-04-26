import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeline_tile/timeline_tile.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          'https://crhscountyline.com/wp-content/uploads/2020/03/Capture.png',
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Gloria Russell',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 32.0),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'UI / UX Designer',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.0,
                  ),
                  socialMediaLinks(
                      'assets/linkedin.png', 'https://www.linkedin.com/feed/'),
                  socialMediaLinks('assets/github.png', 'https://github.com/'),
                  socialMediaLinks(
                      'assets/twitter.png', 'https://twitter.com/'),
                  socialMediaLinks('assets/google-plus.png',
                      'https://myaccount.google.com/intro/profile'),
                  SizedBox(
                    width: 40.0,
                  ),
                ],
              ),
              Text(
                'Skills',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    skillCard('Figma'),
                    skillCard('Adobe'),
                    skillCard('Sketch'),
                    skillCard('Flutter'),
                    skillCard('Dart'),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Experience',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: [
                  experienceTile(
                      position: 'Chief Executive Officer',
                      companyName: 'Facebook',
                      timePeriod: 'February 2004 - March 2104',
                      isFirstTile: true),
                  experienceTile(
                      position: 'Chief Operating Officer',
                      companyName: 'Amazon',
                      timePeriod: 'July 1994 - August 2094'),
                  experienceTile(
                      position: 'Chief Financial Officer',
                      companyName: 'Apple',
                      timePeriod: 'April 1976 - May 2076'),
                  experienceTile(
                      position: 'Chief Marketing Officer',
                      companyName: 'Netflix',
                      timePeriod: 'August 1997 - September 2097'),
                  experienceTile(
                      position: 'Chief Technology Officer',
                      companyName: 'Google',
                      timePeriod: 'September 1998 - October 2098',
                      isLastTile: true),
                ],
              ),
            ],
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
            Placeholder(
              fallbackHeight: 50.0,
              fallbackWidth: 50.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              skillName,
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }

    SizedBox experienceTile(
      {String position,
      String companyName,
      String timePeriod,
      bool isFirstTile = false,
      bool isLastTile = false}) {
    return SizedBox(
      height: 100.0,
      child: TimelineTile(
        isFirst: isFirstTile,
        isLast: isLastTile,
        endChild: Container(
          margin: EdgeInsets.only(left: 15.0, right: 25.0),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: ListTile(
            title: Text(position),
            subtitle: Text('$companyName\n$timePeriod'),
            isThreeLine: true,
          ),
        ),
        beforeLineStyle: LineStyle(color: Colors.grey, thickness: 1.0),
        afterLineStyle: LineStyle(color: Colors.grey, thickness: 1.0),
        indicatorStyle: IndicatorStyle(
          width: 9.0,
          color: Colors.grey,
          padding: EdgeInsets.fromLTRB(4.0, 5.0, 4.0, 5.0),
        ),
      ),
    );
  }
}
